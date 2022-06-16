import { Controller } from "@hotwired/stimulus"

const searchSub = function () {
  $("#welcome").hide(1000);
  const url = "/welcome";
  const form = $("#big-search");
  const formData = form.serialize();
  return $.get(url, formData, null, "script");
};

const liveSearch = function () {
  let timer = 0;
  return $("#big-search-field").bind("keyup", function () {
    clearTimeout(timer);
    return timer = setTimeout(searchSub, 500);
  });
};

$(document).ready(liveSearch);
$(document).on('page:load', liveSearch);