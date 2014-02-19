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
//= require turbolinks
//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require jquery-ui
//= require_tree .

$(function() {
  $("#event_the_date").datepicker({
  	dateFormat: "yy-mm-dd"
  });
});


$(function (){
 	var sub = $(".calendar-sub-details");
 	sub.hide();

 	$(".calendar-details").on('mouseenter', function() {
 		$(this).children(":first").show();
 	});
 	$(".calendar-sub-details").on('mouseenter', function() {
 		$(this).children(":first").show();
 	});
 	$(".calendar-details").on('mouseleave', function() {
 		$(this).children(":first").hide();
 	});
});

