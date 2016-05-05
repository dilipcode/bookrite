ChapterSort = 

  OrderedChapterIds: ->
    JSON.stringify $( "#chapters-list" ).sortable( "toArray" ).map (elId) ->
      elId.split("_")[1]

  saveNewSortOrder: ->
    $.ajax
      method: "PUT"
      url: "/books/#{$('#book')[0].dataset.bookId}"
      dataType: "script"
      data:
        book:
          sorted_chapter_ids: ChapterSort.OrderedChapterIds()

    
  init: ->
    $("#chapters-list").sortable
      handle: ".fa-bars"
      items: "> .chapter"
      placeholder: "sortable-placeholder"
      update: ->        
        ChapterSort.saveNewSortOrder()



$ ->
  $("#book #sidebar #chapters-list .chapter .chapter-title").click (ev) ->
    ev.preventDefault()
    $(@).parents('.chapter').toggleClass('expanded')
  $ ->
    ChapterSort.init()



