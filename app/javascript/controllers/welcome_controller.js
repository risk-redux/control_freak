import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    let timer;
    const delay = 500; // Milliseconds.
    const field = document.getElementById("big-search-field");
    const form = this.element; // Connecting to the form.
    const formData = new FormData(form);

    field.addEventListener("focus", function () {
      field.setSelectionRange(100,100);
    });

    form.addEventListener("input", function () {
      clearTimeout(timer);

      timer = setTimeout(() => {
        for (let entry of formData) {
          console.log(entry);
        }

        const field_length = field.value.length;
        if(field_length == 0 || field_length > 3) {
          form.requestSubmit();
          field.focus();
        }
      }, delay);
    });
  }
}
