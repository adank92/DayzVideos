# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('.side-nav ul a').click (e) ->
    e.preventDefault
    # find the param name from the dropdown id
    param_name = $(this).closest('ul').attr('id')
    # set input's value to link's
    $("input[name="+param_name+"]").val($(this).attr('val'))
    # clear empty params for request, looks nicer
    $('input[value=""]').attr('name', '')
    # submit form
    $('.side-nav form').submit()

# execute jquery with turbolinks and regular requests
$(document).ready ready
$(document).on 'page:load', ready