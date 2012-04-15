/**
 * jQuery Serialize List
 * Copyright (c) 2009 Mike Botsko, Botsko.net LLC
 * Licensed under the MIT (http://www.opensource.org/licenses/mit-license.php)
 * Copyright notice and license must remain intact for legal use
 * Version .2
 *
 * Serialize an unordered or ordered list item. Optional ability
 * to determine which attributes are included. The serialization
 * will be read by PHP as a multidimensional array which you may
 * use for saving state.
 *
 * http://github.com/botskonet/jquery.serialize-list
 */
(function(a){a.fn.serializelist=function(b){var c={attributes:["id"],allow_nest:!0,prepend:"ul",att_regex:!1,is_child:!1},d=a.extend(c,b),e=d.attributes,f="",g,h,i,j,k=function(a,b){if(!d.att_regex)return b;for(h in d.att_regex)if(d.att_regex[h].att===a)return b.replace(d.att_regex[h].regex,"")};return d.is_child||(d.prepend="&"+d.prepend),this.each(function(b,c){a(c).children().each(function(c,h){if(d.allow_nest||e.length>1)for(i in e)g=k(e[i],a(h).attr(e[i])),f+=d.prepend+"["+b+"]["+c+"]["+e[i]+"]="+g;else g=k(e[0],a(h).attr(e[0])),f+=d.prepend+"["+b+"]["+c+"]="+g;d.allow_nest&&(j=d.prepend+"["+b+"]["+c+"][children]",a(h).children().each(function(){if(this.tagName=="UL"||this.tagName=="OL")f+=a(this).serializelist({prepend:j,is_child:!0})})),c++})}),f}})(jQuery);