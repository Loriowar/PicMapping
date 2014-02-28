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
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap

$(document).ready(function() {
  window.click_coordinates_storage = [];
  $('.pic-map').on('click', function(e) {
    var offset = $(this).offset();
    var coordinates = [e.clientX - offset.left, e.clientY - offset.top];
    click_coordinates_storage.push(coordinates);

    // very dirty hack
    var div_element = "\n<div class='asterisk-pointer' style='left: " + (e.clientX-4) +  "px; top: " + (e.clientY-12) + "px;'>*</div>";
    var markers_container = $('.marker-container');
    markers_container.html(markers_container.html() + div_element);
  });

  $('#confirm_mapping_btn').on('click', function(e) {
    var pic_id = $('#pic-id').val();
    var post_url = '/pic/' + pic_id + '/submit_coordinates'
    jQuery.post(post_url, {mapped_coordinates: window.click_coordinates_storage});
  });
});