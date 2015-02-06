echo "## SET RUBY ##"
source /usr/local/share/chruby/chruby.sh
chruby 2.2.0
gem install rake
rake -v
echo "## BUNDLE ##"
bundle install --deployment --without test:development