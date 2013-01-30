// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.blueberry
//= require gmaps4rails/gmaps4rails.base
//= require gmaps4rails/gmaps4rails.googlemaps
//= require jquery.carouFredSel-6.1.0-packed
//= require facebox


$(window).load(function() {
    if($('.blueberry').length > 0){
	$('.blueberry').blueberry({
	    pager: false
	});
	set_texture_height();
    }
});

$(window).resize(function(){
    set_texture_height();
})

function set_texture_height(){
    var tgt_height = $('.slides').css('height');
    $('.slider_texture').css('height', tgt_height);
}

$(document).ready(function(){


    // Floating Bar That Appears On Scrolling
    // $(document).scroll( function() {
    // 	var curr = $('body').scrollTop();
    // 	var tgt_height = $('#header').height();
    // 	var extra = $('.activity_strip').height();
    // 	if ( curr > tgt_height + extra/2){
    // 	    $('#minibar').fadeIn(200);
    // 	    $('#header').addClass('hidden_children');
    // 	    $('#header').children().show();
    // 	}
    // 	else{
    // 	    $('#minibar').fadeOut(200);
    // 	    $('#header').removeClass('hidden_children');
    // 	    $('#header').children().show();
    // 	}
    // });
    

    // Make tabs work
    $('.tabbed_nav>.tab').removeClass('active');
    $('.tabbed_nav>.tab:first-child').addClass('active');
    $('.tab_content>li').hide();
    $('.tab_content>li:first-child').show();
    $('.tabbed_nav>.tab').click(function(){
	$('.tabbed_nav>.tab').removeClass('active');
	$(this).addClass('active');
	var tgt_id = '#' + $(this).attr('rel');
	$('.tab_content>li').slideUp(250);
	console.log(tgt_id);
	$(tgt_id).slideDown(250);
    });

    $('.gallery_thumb').click(function(){
	var tgt = $(this).attr('href');
	$.facebox({image: tgt});
	return false;
    });

})




$(document).ready(function(){
    $('#map').css('height', '500');
    $('#map').css('height', '400');
    $('#map').css('height', '500');




    $(".car_wrapper, #gallery").carouFredSel({
	responsive: true,
	items: 4,
	infinite: true,
	circular: true,
	direction: 'left',
	auto: {
	    pauseOnHover: true,
	    duration: '2000'
	}
    });
    // Using custom configuration
    // $("#carousel").carouFredSel({
    //     items               : 2,
    //     direction           : "up",
    //     scroll : {
    //         items           : 1,
    //         easing          : "elastic",
    //         duration        : 1000,                        
    //         pauseOnHover    : true
    //     }                  
    // });



});



function remove_fields(link) {
    $(link).previous("input[type=hidden]").value = "1";
    $(link).up(".nested-fields").hide();
}

function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g")
    $(link).up().insert({
	before: content.replace(regexp, new_id)
    });
}

