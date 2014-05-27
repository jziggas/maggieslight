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
    $('.flag').tooltip();
});

/*

return $(function() {
        return $(document).on("changeDate", ".bootstrap-datepicker", function(evt) {
            var rails_date;
            rails_date = void 0;
            rails_date = evt.date.getFullYear() + "-" + ("0" + (evt.date.getMonth() + 1)).slice(-2) + "-" + ("0" + evt.date.getDate()).slice(-2);
            return $(this).next("input[type=hidden]").val(rails_date);
        });
    });

$('.form_datetime').datetimepicker({
        autoclose: true,
        todayBtn: true,
        pickerPosition: "bottom-left",
        format: 'mm-dd-yyyy hh:ii'
    });

$('#datetimepicker').datetimepicker();

    $('.form_datetime').datetimepicker({
        autoclose: true,
        todayBtn: true,
        pickerPosition: "bottom-left",

        useSeconds: false,
        minuteStepping: 5,
        showToday: false,
        sideBySide: true
    });
*/