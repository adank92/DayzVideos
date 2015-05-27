jQuery ->
  scrollAjaxRunning = false

  approachingBottomPage = ->
    $(window).scrollTop() > $(document).height() - $(window).height() - 60

  nextPage = ->
    next_page_url = $('.pagination .next_page a').attr('href')
    return if !next_page_url
    scrollAjaxRunning = true
    $('.pagination').html("<img src='assets/loading-spin.svg' width='64' height='64' />")
    $.getScript next_page_url
    .done ->
      scrollAjaxRunning = false

  if $('#infinite-scrolling').size() > 0
    $(window).on 'scroll', ->
      if !scrollAjaxRunning && approachingBottomPage()
        nextPage()
      return
