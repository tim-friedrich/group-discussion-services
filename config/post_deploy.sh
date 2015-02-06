echo "## SET RUBY ##"
source /usr/local/share/chruby/chruby.sh
chruby 2.2.0
ruby -v
which ruby
bundle -v

gem -v
echo "## BUNDLE ##"
bundle install --deployment --without test:development