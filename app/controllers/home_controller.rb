class HomeController < ApplicationController
  def show
    puts 'A'*70
    puts I18n.locale
  end
end
