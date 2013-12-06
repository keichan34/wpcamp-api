$(document).on 'ready', () ->
  supportsReplaceState = typeof history.replaceState == 'function'

  $wordcamps = $ '#wordcamps'
  $load_more = $ '#load-more'

  last_page = 1
  finished = false

  load_page = (pageno = 1, async = true) ->

    $.ajax
      url: Routes.wordcamps_path format: 'json', page: pageno
      async: async
      success: (data, textStatus, jqXHR) ->
        if data.meta.current_page >= data.meta.total_pages
          $load_more.hide()
          finished = true
        else
          last_page = data.meta.current_page + 1

        to_append = []
        $.each data.wordcamps, () ->
          if $wordcamps.find(".wordcamp-tile[data-id='#{this.id}']").length == 0
            tmpl = $ HandlebarsTemplates['wordcamp'](this)
            to_append.push tmpl

        if to_append.length > 0
          $wordcamps.append "<div class='page-placemarker start' data-page='#{data.meta.current_page}'></div>"
          $wordcamps.append to_append
          $wordcamps.append "<div class='page-placemarker end' data-page='#{data.meta.current_page}'></div>"

  $load_more.click (e) ->
    e.preventDefault()
    load_page last_page

  preload_to_page = $wordcamps.data 'load-to-page'

  pages = (x for x in [1..preload_to_page])
  $.each pages, () ->
    load_page this, false

  current_state_page = 1

  $(window).scroll () ->
    # Auto replaceState
    if supportsReplaceState
      page = 1
      $('.page-placemarker.start').each () ->
        _page = parseInt $(this).data('page')
        range_start = $(this).offset().top
        range_end = $(".page-placemarker.end[data-page='#{_page}']").offset().top

        _window_middle = window.scrollY + (window.innerHeight / 2)
        if range_start <= _window_middle and _window_middle <= range_end
          page = _page

      if page != current_state_page
        current_state_page = page
        if page == 1
          history.replaceState {}, '', '/'
        else
          history.replaceState {}, '', "/page/#{ page }"

    # Infinite scroll
    if ($load_more.offset().top - window.innerHeight) - window.scrollY <= 500 and !finished
      load_page last_page
