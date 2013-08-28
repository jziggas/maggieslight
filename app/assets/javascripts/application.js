// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .



/*
function initialize() {
  //js code what you want run always
  //var _glc =_glc || []; _glc.push('all_ag9zfmNsaWNrZGVza2NoYXRyDgsSBXVzZXJzGNig3BIM');
  var glcpath = (('https:' == document.location.protocol) ? 'https://my.clickdesk.com/clickdesk-ui/browser/' :
  'http://my.clickdesk.com/clickdesk-ui/browser/');
  var glcp = (('https:' == document.location.protocol) ? 'https://' : 'http://');
  var glcspt = document.createElement('script'); glcspt.type = 'text/javascript';
  glcspt.async = true; glcspt.src = glcpath + 'livechat-new.js';
  var s = document.getElementsByTagName('script')[0];s.parentNode.insertBefore(glcspt, s);
}
*/
//$(document).ready(initialize);
//$(document).on('page:load', initialize);


/* Raw Code
  var _glc =_glc || []; _glc.push('all_ag9zfmNsaWNrZGVza2NoYXRyDgsSBXVzZXJzGNig3BIM');
  var glcpath = (('https:' == document.location.protocol) ? 'https://my.clickdesk.com/clickdesk-ui/browser/' :
  'http://my.clickdesk.com/clickdesk-ui/browser/');
  var glcp = (('https:' == document.location.protocol) ? 'https://' : 'http://');
  var glcspt = document.createElement('script'); glcspt.type = 'text/javascript';
  glcspt.async = true; glcspt.src = glcpath + 'livechat-new.js';
  var s = document.getElementsByTagName('script')[0];s.parentNode.insertBefore(glcspt, s);
*/

$(document).ready(function() {
  $(".tree-toggle").on('click', function() {
    $(this).parent().children("ul.tree").toggle(200);
  });
  $('.flag').tooltip();
});