# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.side-nav ul a').click (e) ->
    e.preventDefault
    input_name = $(this).closest('ul').attr('id')
    $("input[name="+input_name+"]").val($(this).attr('val'))
    $('.side-nav form').submit()
    