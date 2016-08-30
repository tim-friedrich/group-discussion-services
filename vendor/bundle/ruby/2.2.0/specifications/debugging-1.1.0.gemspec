# -*- encoding: utf-8 -*-
# stub: debugging 1.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "debugging"
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jan Lelis"]
  s.date = "2015-03-26"
  s.description = "Provides useful print debugging helpers."
  s.email = "mail@janlelis.de"
  s.homepage = "https://github.com/janlelis/debugging"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new("~> 2.0")
  s.rubygems_version = "2.4.6"
  s.summary = "Print debugging helpers."

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<paint>, ["< 2.0", ">= 0.9"])
      s.add_runtime_dependency(%q<binding.repl>, ["~> 3.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<rake>, ["~> 10.1"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.4"])
      s.add_development_dependency(%q<rubygems-tasks>, ["~> 0.2"])
    else
      s.add_dependency(%q<paint>, ["< 2.0", ">= 0.9"])
      s.add_dependency(%q<binding.repl>, ["~> 3.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<rake>, ["~> 10.1"])
      s.add_dependency(%q<rdoc>, ["~> 3.0"])
      s.add_dependency(%q<rspec>, ["~> 2.4"])
      s.add_dependency(%q<rubygems-tasks>, ["~> 0.2"])
    end
  else
    s.add_dependency(%q<paint>, ["< 2.0", ">= 0.9"])
    s.add_dependency(%q<binding.repl>, ["~> 3.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<rake>, ["~> 10.1"])
    s.add_dependency(%q<rdoc>, ["~> 3.0"])
    s.add_dependency(%q<rspec>, ["~> 2.4"])
    s.add_dependency(%q<rubygems-tasks>, ["~> 0.2"])
  end
end
