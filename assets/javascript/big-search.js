function delay(callback, ms) {
  let timer = 0;
  
  return function() {
    clearTimeout(timer);
    timer = setTimeout(callback.bind(this), ms || 0);
  };
}

function get_search_hits(index, search) {
  console.log(`Searching for: ${search}`);

  hits = index.search(search, {
    fields: {
      id: { boost: 2 },
      title: { boost: 1 }
    }
  });
  console.log(hits);
  
  hits_string = ""
  hits.forEach(function(value){
    hits_string += `<li><h2>${value.doc.id} ${value.doc.title}</h2></li>`;
  });
  $("#big-search-results ul").html(hits_string);
}

function prep_indices(data) {
  index = elasticlunr(function () {
    this.addField('id');
    this.addField('title');
    this.setRef('id');
  });
  
  indices = [];

  data.catalog.groups.forEach(function(family) {
    indices.push({
      "id": family.id,
      "title": family.title
    });

    family.controls.forEach(function(control) {
      indices.push({
        "id": control.id,
        "title": control.title
      });

      if(control.controls) {
        control.controls.forEach(function(enhancement) {
          indices.push({
            "id": enhancement.id,
            "title": enhancement.title
          });
        });
      }
    });
  });

  indices.forEach(function(value) {
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
      }, 500));
    })
    .catch((error) => {
      console.error('There has been a problem with your fetch operation:', error);
    });
}