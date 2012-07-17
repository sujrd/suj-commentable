$(document).on('click', '.suj-commentable-reply-toggle', (evt, data, status, xhr) ->
  $('.suj-commentable-form',$(this).parents('.suj-commentable-item')).toggle()
  return false
)

$(document).on('ajax:success', '.suj-commentable-item .suj-commentable-form', (evt, data, status, xhr) ->
  $(this).toggle()
  return false
)