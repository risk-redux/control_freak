function delay(callback, ms) {
  let timer = 0;
  
  return function() {
    clearTimeout(timer);
    timer = setTimeout(callback.bind(this), ms || 0);
  };
}

function get_search_hits(index, search) {
  console.log(`Searching for: ${search}`);

  hits = index.search(search);
  console.log(hits);
  
  hits_string = ""
  hits.forEach(function(value){
    hits_string += `<li>${value.doc.title}</li>\n`;
  });
  $("#big-search-results ul").html(hits_string);
}

function prep_indices(data) {
  index = elasticlunr(function () {
    this.addField('title');
    this.addField('body');
    this.setRef('id');
  });
  
  indices = [];

  console.log(data);

  indices.forEach(function(value) {
    console.log(value);
    index.addDoc(value);
  });

  return index;
}

function load_big_search(data) {
  fetch("assets/data/nist-sp-800-53-rev-5-catalog.json")
    .then((response) => response.json())
    .then((data) => {
      console.log(`Successfully fetched catalog: ${data.catalog.metadata.title} (${data.catalog.uuid})`);
      
      var index = prep_indices(data);

      $("#big-search-field").on("keyup", delay(function() {
        search = $("#big-search-field").val();
        console.log(search);
        get_search_hits(index, search);
      }, 200));
    })
    .catch((error) => {
      console.error('There has been a problem with your fetch operation:', error);
    });
}