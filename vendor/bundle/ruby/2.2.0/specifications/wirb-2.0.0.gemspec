# -*- encoding: utf-8 -*-
# stub: wirb 2.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "wirb"
  s.version = "2.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jan Lelis"]
  s.date = "2015-03-29"
  s.description = "WIRB highlights inspected Ruby objects. It is based on the original Wirble. You can create new color schemas using yaml."
  s.email = "mail@janlelis.de"
  s.extra_rdoc_files = ["README.md", "CHANGELOG.md", "COPYING.txt"]
  s.files = ["CHANGELOG.md", "COPYING.txt", "README.md"]
  s.homepage = "https://github.com/janlelis/wirb"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new("~> 2.0")
  s.rubygems_version = "2.4.6"
  s.summary = "WIRB Interactive Ruby"

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<paint>, ["< 2.0", ">= 0.9"])
      s.add_development_dependency(%q<rspec>, ["~> 2.14"])
      s.add_development_dependency(%q<rake>, ["~> 10.4"])
      s.add_development_dependency(%q<ruby_engine>, ["~> 1.0"])
    else
      s.add_dependency(%q<paint>, ["< 2.0", ">= 0.9"])
      s.add_dependency(%q<rspec>, ["~> 2.14"])
      s.add_dependency(%q<rake>, ["~> 10.4"])
      s.add_dependency(%q<ruby_engine>, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<paint>, ["< 2.0", ">= 0.9"])
    s.add_dependency(%q<rspec>, ["~> 2.14"])
    s.add_dependency(%q<rake>, ["~> 10.4"])
    s.add_dependency(%q<ruby_engine>, ["~> 1.0"])
  end
end
