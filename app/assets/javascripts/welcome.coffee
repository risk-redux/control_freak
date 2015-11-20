# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#updateResults = ->
  #$("#big-search-results").html(Math.random())
  #$("#big-search-results").html("#{render 'welcome/shared/big_search_results'}")

searchSub = ->
  $("#welcome").hide(1000)
  url = "/welcome"
  form = $("#big-search")
  formData = form.serialize()
  $.get(url, formData, null, "script")

liveSearch = ->
  timer = 0
  $("#big-search-field").bind("keyup", ->
    clearTimeout(timer)
    timer = setTimeout(searchSub, 200)
  )

$(document).ready(liveSearch)
$(document).on('page:load', liveSearch)
