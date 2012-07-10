$(document).on('click', '.suj-commentable-reply-toggle', (evt, data, status, xhr) ->
  $('.suj-commentable-reply-form',$(this).parents('.suj-commentable-item')).toggle()
  return false
)

$(document).on('ajax:success', '.suj-commentable-reply-form', (evt, data, status, xhr) ->
  $(this).toggle()
  return false
)