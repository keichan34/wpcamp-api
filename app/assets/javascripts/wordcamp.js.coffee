$(document).on 'ready', () ->
  supportsReplaceState = typeof history.replaceState == 'function'

  $wordcamps = $ '#wordcamps'
  $load_more = $ '#load-more'
  $query     = $ '#query'

  return if $wordcamps.length == 0

  last_page = 1
  finished = false

  load_page = (pageno = 1, async = true) ->
    load_page_with_helper Routes.wordcamps_path, {}, pageno, async

  load_search_page = (pageno = 1, async = true) ->
    load_page_with_helper Routes.search_wordcamps_path, {q: $query.val()}, pageno, async

  load_page_with_helper = (helper, args = {}, pageno = 1, async = true) ->
    _args = $.extend { format: 'json', page: pageno }, args
    $.ajax
      url: helper _args
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

  current_helper = load_page

  $load_more.click (e) ->
    e.preventDefault()
    current_helper last_page

  preload_to_page = $wordcamps.data 'load-to-page'

  pages = (x for x in [1..preload_to_page])
  $.each pages, () ->
    current_helper this, false

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
      current_helper last_page

  $query.keyup (e) ->
    val = $query.val()
    last_page = 1

    if val.length <= 3 and current_helper == load_search_page
      $wordcamps.empty()
      current_helper = load_page

      load_page()
      return

    current_helper = load_search_page

    $wordcamps.empty()
    load_search_page()
