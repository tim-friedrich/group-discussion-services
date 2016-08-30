# -*- encoding: utf-8 -*-
# stub: prawn-rails 0.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "prawn-rails"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Carlos Ortiz"]
  s.date = "2015-01-12"
  s.description = "Prawn Handler for RoR 3.x/4.x projects handles and registers pdf formats"
  s.email = ["chrono.dark@gmail.com"]
  s.homepage = "https://github.com/cortiz/prawn-rails"
  s.rubygems_version = "2.4.6"
  s.summary = "Prawn Handler for RoR 3.x/4.x projects"

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<prawn>, [">= 0"])
      s.add_runtime_dependency(%q<prawn-table>, [">= 0"])
      s.add_runtime_dependency(%q<rails>, [">= 3.1.0"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
      s.add_development_dependency(%q<pdf-reader>, [">= 0"])
    else
      s.add_dependency(%q<prawn>, [">= 0"])
      s.add_dependency(%q<prawn-table>, [">= 0"])
      s.add_dependency(%q<rails>, [">= 3.1.0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<pdf-reader>, [">= 0"])
    end
  else
    s.add_dependency(%q<prawn>, [">= 0"])
    s.add_dependency(%q<prawn-table>, [">= 0"])
    s.add_dependency(%q<rails>, [">= 3.1.0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<pdf-reader>, [">= 0"])
  end
end
