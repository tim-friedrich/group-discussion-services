echo "## SET RUBY ##"
source /usr/local/share/chruby/chruby.sh
chruby 2.2.0
echo "## BUNDLE ##"
bundle install --deployment --without test:development
echo "## PRECOMPILE ASSETS ##"
bundle exec dotenv rake assets:precompile
echo "## RESTART SERVER ##"
sudo /etc/init.d/thin-staging restart
