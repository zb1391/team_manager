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
//= require jquery.turbolinks
//= require_tree .

$(function() {
	$('.datepicker').each(function(){
    $(this).datepicker({ dateFormat: "yy-mm-dd"});
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

function displayInstaComment(current){
 	var sub = $("ul.instacomments").children("li");
 	sub.hide();
 	var curComment = $("ul.instacomments").children("li").eq(current);
 	curComment.show();
}


function remove_fields (link) {
	$(link).previous("input[type=hidden]").value = "1"
	$(link).up(".fields").hide();
}

