function load_big_search(data) {
  $("#big-search-field").on("keyup", function() {
    $("#big-search-results").text(`${data.catalog.metadata.title} (${data.catalog.uuid})`);
  });
}