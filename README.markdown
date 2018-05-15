# control_freak

Utterly exhausted with the process of Google searching for a NIST special publication, searching for a particular version of in the document library, loading the file in some Adobe app, and then <kbd>⌘ + F</kbd>-ing my way through the hundreds of pages… I took matters into my own hands.

Thus was born [control_freak][control_freak]. It’s a simple Ruby on Rails application filled with data that I parsed out of the frequently reference 800-53 (essentially a catalogue of security controls). The application supports some searching capabilities (poorly) and a simpler organization of all the interconnected information that is currently locked into those god awful PDFs. Huzzah!

[control_freak]: http://controlfreak.io

# Contributing

I'm open to [Issues](issues) and [Pull Requests](pulls)!

## Getting started

1. Clone the code from this repository.
1. Install dependencies (i.e., listed in `Gemfile`). I use [Bundler](https://bundler.io/), so a simple `bundle install` gets everything in order.
1. Create a file inside `config/` called "application.yml", and define the following environmental variables:
    1. `SECRET_KEY_BASE`
    1. `RAILS_ENV`
    1. `DATABASE_NAME`
    1. `DATABASE_USER`
    1. `DATABASE_HOST`
    1. `DATABASE_PASSWORD`
1. Modify the `config/database.yml` file as appropriate for the target environment.
1. Create the specified database user with appropriate permissions to create a new schema.
1. Bootstrap the database:
`> rails db:create && rails db:schema:load`
1. Populate the database:
`> rails db:seed`
1. Run the Rails server:
`> rails s`
