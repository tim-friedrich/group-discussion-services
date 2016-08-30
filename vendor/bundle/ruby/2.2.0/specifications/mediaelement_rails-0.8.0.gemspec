# -*- encoding: utf-8 -*-
# stub: mediaelement_rails 0.8.0 ruby lib

Gem::Specification.new do |s|
  s.name = "mediaelement_rails"
  s.version = "0.8.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Mark Oleson", "Tobias Schlottke", "Pete Browne"]
  s.date = "2014-04-12"
  s.description = "A MediaElement gem(engine) for Rails. Makes embedding HTML5 video easy."
  s.email = ["fusion2004@gmail.com", "tobias.schlottke@gmail.com", "me@petebrowne.com"]
  s.homepage = "https://github.com/tobsch/mediaelement_rails"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.6"
  s.summary = "MediaElement.js for Rails"

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, [">= 3.1"])
      s.add_runtime_dependency(%q<jquery-rails>, [">= 1.0"])
      s.add_development_dependency(%q<rails>, [">= 3.1"])
      s.add_development_dependency(%q<i18n>, [">= 0"])
      s.add_development_dependency(%q<turn>, [">= 0"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
      s.add_development_dependency(%q<thor>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<railties>, [">= 3.1"])
      s.add_dependency(%q<jquery-rails>, [">= 1.0"])
      s.add_dependency(%q<rails>, [">= 3.1"])
      s.add_dependency(%q<i18n>, [">= 0"])
      s.add_dependency(%q<turn>, [">= 0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<thor>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<railties>, [">= 3.1"])
    s.add_dependency(%q<jquery-rails>, [">= 1.0"])
    s.add_dependency(%q<rails>, [">= 3.1"])
    s.add_dependency(%q<i18n>, [">= 0"])
    s.add_dependency(%q<turn>, [">= 0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<thor>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
