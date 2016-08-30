# -*- encoding: utf-8 -*-
# stub: ruby_info 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "ruby_info"
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jan Lelis"]
  s.date = "2014-01-15"
  s.description = "Provides a RubyInfo class that simplifies accessing global information. Run RubyInfo.list to get started."
  s.email = "mail@janlelis.de"
  s.homepage = "https://github.com/janlelis/ruby_info"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.6"
  s.summary = "Adds the RubyInfo pseudo-constant."

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<rake>, ["~> 10.1"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.4"])
      s.add_development_dependency(%q<rubygems-tasks>, ["~> 0.2"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<rake>, ["~> 10.1"])
      s.add_dependency(%q<rdoc>, ["~> 3.0"])
      s.add_dependency(%q<rspec>, ["~> 2.4"])
      s.add_dependency(%q<rubygems-tasks>, ["~> 0.2"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<rake>, ["~> 10.1"])
    s.add_dependency(%q<rdoc>, ["~> 3.0"])
    s.add_dependency(%q<rspec>, ["~> 2.4"])
    s.add_dependency(%q<rubygems-tasks>, ["~> 0.2"])
  end
end
