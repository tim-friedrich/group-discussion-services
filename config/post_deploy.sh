echo "## SET RUBY ##"
source /usr/local/share/chruby/chruby.sh
echo "## BUNDLE ##"
bundle install --deployment --without test:development