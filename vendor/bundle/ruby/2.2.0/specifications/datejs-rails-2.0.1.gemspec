# -*- encoding: utf-8 -*-
# stub: datejs-rails 2.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "datejs-rails"
  s.version = "2.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Derek Prior"]
  s.date = "2012-12-18"
  s.homepage = "https://github.com/derekprior/datejs-rails"
  s.rubygems_version = "2.4.6"
  s.summary = "The datejs Javascript library ready to play with Rails"

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, [">= 3.1"])
    else
      s.add_dependency(%q<railties>, [">= 3.1"])
    end
  else
    s.add_dependency(%q<railties>, [">= 3.1"])
  end
end
