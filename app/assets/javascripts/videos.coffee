# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  # side-nav functionality
  $('.side-nav ul a').click (e) ->
    e.preventDefault
    # find the param name from the dropdown id
    param_name = $(this).closest('ul').attr('id')
    # set input's value to link's
    $("input[name="+param_name+"]").val($(this).attr('val'))
    # submit form
    $('.side-nav form').submit()

  # load the video when the modal is shown
  $('#videoModal').on 'show.bs.modal', (e) ->
    button = $(e.relatedTarget)
    youtube_url = button.data('youtube-url')
    $(this).find('iframe').attr('src', youtube_url)

  # unload the video when the modal is hiden
  $('#videoModal').on 'hide.bs.modal', (e) ->
    $(this).find('iframe').removeAttr('src')

# execute jquery with turbolinks and regular requests
$(document).ready ready
$(document).on 'page:load', ready