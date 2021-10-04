heroku buildpacks: add --index 1 heroku/nodejs
heroku buildpacks: add --index 2 heroku/ruby

web: bundle exec bin/rails server -p $PORT -e $RAILS_ENV
console: bundle exec bin/rails console
