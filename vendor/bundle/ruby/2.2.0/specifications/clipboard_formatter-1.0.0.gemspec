# -*- encoding: utf-8 -*-
# stub: clipboard_formatter 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "clipboard_formatter"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jan Lelis"]
  s.date = "2015-04-06"
  s.description = "Copies the list of failed examples to your clipboard so that you can restart them easily."
  s.email = "mail@janlelis.de"
  s.homepage = "https://github.com/janlelis/clipboard_formatter"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new("~> 2.0")
  s.rubygems_version = "2.4.6"
  s.summary = "A clipboard formatter for RSpec."

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rspec>, ["~> 3.0"])
      s.add_runtime_dependency(%q<clipboard>, ["~> 1.0"])
    else
      s.add_dependency(%q<rspec>, ["~> 3.0"])
      s.add_dependency(%q<clipboard>, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 3.0"])
    s.add_dependency(%q<clipboard>, ["~> 1.0"])
  end
end
