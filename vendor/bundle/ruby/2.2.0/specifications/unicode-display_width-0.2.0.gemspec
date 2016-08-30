# -*- encoding: utf-8 -*-
# stub: unicode-display_width 0.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "unicode-display_width"
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jan Lelis"]
  s.date = "2015-02-05"
  s.description = "This gem adds String#display_size to get the display size of a string using EastAsianWidth.txt."
  s.email = "mail@janlelis.de"
  s.extra_rdoc_files = ["README.rdoc", "LICENSE.txt", "CHANGELOG.txt"]
  s.files = ["CHANGELOG.txt", "LICENSE.txt", "README.rdoc"]
  s.homepage = "http://github.com/janlelis/unicode-display_width"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.6"
  s.summary = "Support for east_asian_width string widths."

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 3.2"])
      s.add_development_dependency(%q<rake>, ["~> 10.4"])
    else
      s.add_dependency(%q<rspec>, ["~> 3.2"])
      s.add_dependency(%q<rake>, ["~> 10.4"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 3.2"])
    s.add_dependency(%q<rake>, ["~> 10.4"])
  end
end
