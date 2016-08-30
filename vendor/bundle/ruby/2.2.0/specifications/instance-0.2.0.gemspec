# -*- encoding: utf-8 -*-
# stub: instance 0.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "instance"
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Thomas Sawyer"]
  s.date = "2014-02-02"
  s.description = "Instance is a spin-off of Ruby Facets. It provides a simple convenient API\nfor accessing an object's state."
  s.email = ["transfire@gmail.com"]
  s.extra_rdoc_files = ["LICENSE.txt", "README.md", "HISTORY.md"]
  s.files = ["HISTORY.md", "LICENSE.txt", "README.md"]
  s.homepage = "http://rubyworks.github.com/instance"
  s.licenses = ["BSD-2-Clause"]
  s.rubygems_version = "2.4.6"
  s.summary = "Object Instance API"

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<qed>, [">= 0"])
      s.add_development_dependency(%q<ae>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
    else
      s.add_dependency(%q<qed>, [">= 0"])
      s.add_dependency(%q<ae>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
    end
  else
    s.add_dependency(%q<qed>, [">= 0"])
    s.add_dependency(%q<ae>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
  end
end
