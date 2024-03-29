#!/bin/bash
echo "## COPY ENV ##"
cp .env-production .env
echo "## SET RUBY ##"
source /usr/local/share/chruby/chruby.sh
chruby 2.2.1
ruby -v
echo "## BUNDLE ##"
bundle install --deployment --without test:development
echo "## RUN ERB HACK ##"
bundle exec dotenv ruby config/initializers/private_pub_erb.rb
echo "## PRECOMPILE ASSETS ##"
bundle exec dotenv rake assets:precompile
echo "## MIGRATE DATABASE ##"
bundle exec dotenv rake db:migrate
echo "## SEED DATABASE ##"
bundle exec dotenv rake db:seed
echo "## RESTART SERVER ##"
sudo /etc/init.d/thin-production restart
