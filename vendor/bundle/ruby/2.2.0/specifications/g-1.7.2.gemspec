# -*- encoding: utf-8 -*-
# stub: g 1.7.2 ruby lib

Gem::Specification.new do |s|
  s.name = "g"
  s.version = "1.7.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["jugyo"]
  s.date = "2013-01-22"
  s.description = "It works like Kernel.p with growl :)"
  s.email = ["jugyo.org@gmail.com"]
  s.homepage = "http://github.com/jugyo/g"
  s.rubyforge_project = "g"
  s.rubygems_version = "2.4.6"
  s.summary = "The Kernel.g"

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<ruby_gntp>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<ruby_gntp>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<ruby_gntp>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
