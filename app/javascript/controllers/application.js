import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

$(document).ready(function() {
    $('tr[data-link]').click(function() {
        const href = $(this).attr('data-link');
        if (href) {
            window.location = href;
        }
    });
});