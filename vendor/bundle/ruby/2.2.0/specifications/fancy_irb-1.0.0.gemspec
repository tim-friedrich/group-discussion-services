# -*- encoding: utf-8 -*-
# stub: fancy_irb 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "fancy_irb"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jan Lelis"]
  s.date = "2015-03-29"
  s.description = "FancyIrb makes IRB # => friendly."
  s.email = "mail@janlelis.de"
  s.homepage = "http://github.com/janlelis/fancy_irb"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.requirements = ["Windows: ansicon <https://github.com/adoxa/ansicon>"]
  s.rubygems_version = "2.4.6"
  s.summary = "FancyIrb makes IRB friendly."

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<paint>, ["< 2.0", ">= 0.9"])
      s.add_runtime_dependency(%q<unicode-display_width>, [">= 0.2.0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.2"])
      s.add_development_dependency(%q<rake>, ["~> 10.4"])
    else
      s.add_dependency(%q<paint>, ["< 2.0", ">= 0.9"])
      s.add_dependency(%q<unicode-display_width>, [">= 0.2.0"])
      s.add_dependency(%q<rspec>, ["~> 3.2"])
      s.add_dependency(%q<rake>, ["~> 10.4"])
    end
  else
    s.add_dependency(%q<paint>, ["< 2.0", ">= 0.9"])
    s.add_dependency(%q<unicode-display_width>, [">= 0.2.0"])
    s.add_dependency(%q<rspec>, ["~> 3.2"])
    s.add_dependency(%q<rake>, ["~> 10.4"])
  end
end
