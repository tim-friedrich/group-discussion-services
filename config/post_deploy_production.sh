#!/bin/bash
echo "## SET RUBY ##"
source /usr/local/share/chruby/chruby.sh
chruby 2.2.0
ruby -v
echo "## BUNDLE ##"
bundle install --deployment --without test:development
echo "## PRECOMPILE ASSETS ##"
bundle exec dotenv rake assets:precompile
echo "## MIGRATE DATABASE ##"
bundle exec dotenv rake db:migrate
echo "## RESTART SERVER ##"
sudo /etc/init.d/thin-production restart
