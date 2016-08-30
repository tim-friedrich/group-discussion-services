# -*- encoding: utf-8 -*-
# stub: code 0.9.0 ruby lib

Gem::Specification.new do |s|
  s.name = "code"
  s.version = "0.9.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jan Lelis"]
  s.date = "2015-03-28"
  s.description = "Displays a method's code (from source or docs)."
  s.email = "mail@janlelis.de"
  s.homepage = "https://github.com/janlelis/code"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new("~> 2.0")
  s.rubygems_version = "2.4.6"
  s.summary = "Displays a method's code."

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<method_source>, [">= 0.8.2", "~> 0.8"])
      s.add_runtime_dependency(%q<coderay>, ["~> 1.1"])
    else
      s.add_dependency(%q<method_source>, [">= 0.8.2", "~> 0.8"])
      s.add_dependency(%q<coderay>, ["~> 1.1"])
    end
  else
    s.add_dependency(%q<method_source>, [">= 0.8.2", "~> 0.8"])
    s.add_dependency(%q<coderay>, ["~> 1.1"])
  end
end
