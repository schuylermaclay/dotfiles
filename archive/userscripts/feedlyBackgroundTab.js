
// ==UserScript==
// @name           Feedly Background Tab
// @description    Open link by background tab for Feedly
// @include        http*://cloud.feedly.com/*
// @include        http*://feedly.com/*
// @grant          GM.openInTab
// @version 0.0.1
// ==/UserScript==


var key = ';';

(function() {
  var onKeyDown = function(event) {
    if(event.key == key && !event.shiftKey) {
     var target = document.getElementsByClassName('inlineFrame selected');
     if (target == null) {
       return;
     }
     link = target[0].getElementsByClassName('entryTitle title')[0].href;
     console.log(link);
      GM.openInTab(link);
   }
 }
 document.addEventListener('keydown', onKeyDown, false);
})();
