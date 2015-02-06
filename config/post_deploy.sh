echo "## SET RUBY ##"
source /usr/local/share/chruby/chruby.sh
chruby 2.2.0
gem install rake
rake --version
echo "## BUNDLE ##"
bundle install --deployment --without test:development