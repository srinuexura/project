// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require admin/spree_core
//= require admin/spree_auth
//= require admin/spree_promo
//= require cocoon
//= require_directory .


$(document).ready(function() {
    $(".wysiwyg").markItUp(mySettings);
});//= require admin/spree_essentials//= require admin/spree_social


function remove_fields(link) {
    $(link).previous("input[type=hidden]").value = "1";
    $(link).parent(".nested-field").hide();
}

function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g")
    $(link).up().insert({
	before: content.replace(regexp, new_id)
    });

}
