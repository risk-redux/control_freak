function parse_family(families) {
  const params = new Proxy(new URLSearchParams(window.location.search), {
    get: (searchParams, prop) => searchParams.get(prop),
  });

  const family_match = /^[a-z]{2}$/i;

  family = params.family;

  if(family_match.test(family)) {
    console.log(`Retrieving family: ${family}`);

    families.forEach(function(family_json) {
      if(family == family_json.id) {
        return family_json;
      }
    });
  } else {
    console.log("No valid family from query string.");
   
    return null;
  }
}

// function parse_format() {
//   const params = new Proxy(new URLSearchParams(window.location.search), {
//     get: (searchParams, prop) => searchParams.get(prop),
//   });

//   const format_match = /^json/i;

//   format = params.format;

//   if(format_match.test(format)) {
//     console.log("Rendering JSON.");
    
//     return 'json';
//   } else {
//     console.log("Defaulting to HTML.");
    
//     return null;
//   }
// }

function count_controls(collection) {
  return collection.length;
}

function count_enhancements(collection) {
  control_count = 0;

  collection.forEach(function(control) {
    if(control.controls) {
      control_count += count_controls(control.controls);
    }
  });

  return control_count;
}

function render_periodic_table_of_controls(data) {
  families_string = ``;

  data.catalog.groups.forEach(function(family) {
    families_string +=
      `<div class="col mb-4">
        <div class="card h-100">
          <div class="card-body">
            <a class="stretched-link" href="/families/${family.id.toUpperCase()}"></a>
            <p class="card-text text-end text-danger">
              <strong>${count_controls(family.controls)}</strong>
              /
              <em>${count_enhancements(family.controls)}</em>
            </p>
            <h2 class="card-title display-3 text-center">
              <abbr title="${family.title}">${family.id.toUpperCase()}</abbr>
            </h2>
            <p class="card-text text-center d-none d-md-block">
              <small class="text-muted"><em>${family.title}</em></small>
            </p>
          </div>
        </div>
      </div>`;
  });

  $("#periodic-table-of-controls").html(families_string);
}

function load_families() {
  fetch("../assets/data/nist-sp-800-53-rev-5-catalog.json")
    .then((response) => response.json())
    .then((data) => {
      console.log(`Successfully fetched catalog: ${data.catalog.metadata.title} (${data.catalog.uuid})`);

      // format = parse_format();
      family = parse_family(data.catalog.groups);

      render_periodic_table_of_controls(data);
    })
    .catch((error) => {
      console.error('There has been a problem with your fetch operation:', error);
    });
}