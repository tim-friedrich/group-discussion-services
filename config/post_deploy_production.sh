#!/bin/bash
echo "## COPY ENV ##"
cp .env-production .env
echo "## SET RUBY ##"
source /usr/local/share/chruby/chruby.sh
chruby 2.2.0
ruby -v
echo "## BUNDLE ##"
bundle install --deployment --without test:development
echo "## RUN INITIALIZERS ##"
bundle exec dotenv rails runner 'puts Rails.env'
echo "## PRECOMPILE ASSETS ##"
bundle exec dotenv rake assets:precompile
echo "## MIGRATE DATABASE ##"
bundle exec dotenv rake db:migrate
echo "## RESTART SERVER ##"
sudo /etc/init.d/thin-production restart
