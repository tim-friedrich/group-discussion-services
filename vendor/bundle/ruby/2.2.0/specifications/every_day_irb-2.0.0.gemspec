# -*- encoding: utf-8 -*-
# stub: every_day_irb 2.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "every_day_irb"
  s.version = "2.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jan Lelis"]
  s.date = "2015-03-29"
  s.description = "EveryDayIrb simplifies daily life in IRB with commands like: ls, cat, rq, rrq, ld, reset!, ..."
  s.email = "mail@janlelis.de"
  s.extra_rdoc_files = ["README.md", "CHANGELOG-EVERYDAYIRB.txt", "MIT-LICENSE.txt"]
  s.files = ["CHANGELOG-EVERYDAYIRB.txt", "MIT-LICENSE.txt", "README.md"]
  s.homepage = "http://github.com/janlelis/irbtools"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new("~> 2.0")
  s.rubygems_version = "2.4.6"
  s.summary = "EveryDayIrb simplifies daily life in IRB."

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<cd>, ["~> 1.0"])
    else
      s.add_dependency(%q<cd>, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<cd>, ["~> 1.0"])
  end
end
