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

$(document).ready(function() {
  $(".tree-toggle").on('click', function() {
    $(this).parent().children("ul.tree").toggle(200);
  });
  $('.flag').tooltip();
  // zopim_chat();
});

/* Place this in the application layout for zopim chat, inside .box01 under the body. Works with TurboLinks.

    :javascript
      function zopim_chat(){
        $('[__jx__id], embed#__zopnetworkswf').remove();
        window.$zopim = null;
        (function(d,s){
          var z = $zopim = function(c){
            z._.push(c)
          }, $ = z.s = d.createElement(s), e = d.body.getElementsByTagName(s)[0];
          z.set = function(o){
            z.set._.push(o)
          };
          z._ = [];
          z.set._ = [];
          $.async = !0;
          $.setAttribute('charset','utf-8');
          $.src = '//cdn.zopim.com/?<PUT YOUR API CODE HERE.. MINE IS IN LASTPASS>';
          z.t = +new Date;
          $.type = 'text/javascript';
          e.parentNode.insertBefore($,e)
        })(document,'script');
      }

*/