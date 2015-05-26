# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  # show alerts 
  $("#alerts").fadeIn()
  # hide spinner and overlay
  $('#overlay').hide()

  # side-nav functionality
  $('.side-nav ul a').click (e) ->
    e.preventDefault
    # reset active options
    $(this).closest('ul').find('li').removeClass('active')
    # highlight active option
    $(this).closest('li').addClass('active')
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

  # freewall grid implementarion
  wall = new freewall('#videos-container')
  wall.reset({
        selector: '.video',
        animate: true,
        cellW: 332,
        cellH: 260,
        onResize: ->
          wall.refresh();
      });
  wall.fitWidth()
  $(window).trigger("resize")

# spinner and overlay triggers
$(document).on 'submit', 'form', ->
  $('#overlay').fadeIn(500)
$(document).ajaxStop ->
  $('#overlay').fadeOut(500)

# execute jquery with turbolinks and regular requests
jQuery ready
$(document).on 'page:load', ready