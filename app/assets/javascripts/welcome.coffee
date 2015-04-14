# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

updateResults = ->
  $("#big-search-results").html("Searching...")

searchSub = ->
  url = "/welcome"
  form = $("#big-search")
  formData = form.serialize()
  $.get(url, formData, updateResults)

liveSearch = ->
  $("#big-search-field").bind("keyup", searchSub)

#$(document).ready(liveSearch)
#$(document).on('page:load', liveSearch)
