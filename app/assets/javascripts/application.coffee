$(document).ready ->
  $('tr[data-link]').click ->
    href = $(this).attr('data-link')
    if href
      window.location = href
    return
  return