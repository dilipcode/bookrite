@ChapterUtils = {}  
ChapterUtils.BindNewChapterCancelLink = ->
  $('#cancel-new-chapter-form').click ->
    $('#new-chapter-form').hide()
    $('#new-chapter-form-trigger').show()
  
  
$ ->
  $('#new-chapter-form').hide()
  $('#new-chapter-form-trigger').click ->
    $('#new-chapter-form').show()
    $(@).hide()
  ChapterUtils.BindNewChapterCancelLink()  

