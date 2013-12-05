$(document).on 'ready', () ->
  $wordcamps = $ '#wordcamps'
  $load_more = $ '#load-more'

  last_page = 1

  load_page = (pageno = 1) ->

    $.ajax
      url: Routes.wordcamps_path format: 'json', page: pageno
      success: (data, textStatus, jqXHR) ->
        if data.meta.current_page == data.meta.total_pages
          $load_more.hide()

        $.each data.wordcamps, () ->
          if $wordcamps.find("li[data-id='#{this.id}']").length == 0
            $wordcamps.append HandlebarsTemplates['wordcamp'](this)

  $load_more.click (e) ->
    e.preventDefault()
    load_page ++last_page

  load_page 1
