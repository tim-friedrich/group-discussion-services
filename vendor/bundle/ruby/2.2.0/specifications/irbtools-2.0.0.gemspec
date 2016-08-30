# -*- encoding: utf-8 -*-
# stub: irbtools 2.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "irbtools"
  s.version = "2.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jan Lelis"]
  s.date = "2015-03-29"
  s.description = "Irbtools make Ruby's IRB more productive."
  s.email = "mail@janlelis.de"
  s.extra_rdoc_files = ["README.md", "CONFIGURE.md", "CHANGELOG.txt", "MIT-LICENSE.txt"]
  s.files = ["CHANGELOG.txt", "CONFIGURE.md", "MIT-LICENSE.txt", "README.md"]
  s.homepage = "https://github.com/janlelis/irbtools"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new("~> 2.0")
  s.rubygems_version = "2.4.6"
  s.summary = "Irbtools happy IRB."

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 3.2"])
      s.add_development_dependency(%q<rake>, ["~> 10.4"])
      s.add_runtime_dependency(%q<every_day_irb>, ["~> 2.0"])
      s.add_runtime_dependency(%q<fancy_irb>, ["~> 1.0"])
      s.add_runtime_dependency(%q<wirb>, ["~> 2.0"])
      s.add_runtime_dependency(%q<hirb>, [">= 0.7.3", "~> 0.7"])
      s.add_runtime_dependency(%q<binding.repl>, ["~> 3.0"])
      s.add_runtime_dependency(%q<paint>, ["< 2.0", ">= 0.9"])
      s.add_runtime_dependency(%q<clipboard>, [">= 1.0.6", "~> 1.0"])
      s.add_runtime_dependency(%q<interactive_editor>, [">= 0.0.10", "~> 0.0"])
      s.add_runtime_dependency(%q<coderay>, ["~> 1.1"])
      s.add_runtime_dependency(%q<debugging>, ["~> 1.1"])
      s.add_runtime_dependency(%q<g>, [">= 1.7.2", "~> 1.7"])
      s.add_runtime_dependency(%q<code>, ["~> 0.9"])
      s.add_runtime_dependency(%q<ori>, ["~> 0.1.0"])
      s.add_runtime_dependency(%q<methodfinder>, ["~> 2.0"])
      s.add_runtime_dependency(%q<method_locator>, [">= 0.0.4", "~> 0.0"])
      s.add_runtime_dependency(%q<ruby_version>, ["~> 1.0"])
      s.add_runtime_dependency(%q<ruby_engine>, ["~> 1.0"])
      s.add_runtime_dependency(%q<ruby_info>, ["~> 1.0"])
      s.add_runtime_dependency(%q<os>, ["~> 0.9"])
      s.add_runtime_dependency(%q<instance>, ["~> 0.2"])
    else
      s.add_dependency(%q<rspec>, ["~> 3.2"])
      s.add_dependency(%q<rake>, ["~> 10.4"])
      s.add_dependency(%q<every_day_irb>, ["~> 2.0"])
      s.add_dependency(%q<fancy_irb>, ["~> 1.0"])
      s.add_dependency(%q<wirb>, ["~> 2.0"])
      s.add_dependency(%q<hirb>, [">= 0.7.3", "~> 0.7"])
      s.add_dependency(%q<binding.repl>, ["~> 3.0"])
      s.add_dependency(%q<paint>, ["< 2.0", ">= 0.9"])
      s.add_dependency(%q<clipboard>, [">= 1.0.6", "~> 1.0"])
      s.add_dependency(%q<interactive_editor>, [">= 0.0.10", "~> 0.0"])
      s.add_dependency(%q<coderay>, ["~> 1.1"])
      s.add_dependency(%q<debugging>, ["~> 1.1"])
      s.add_dependency(%q<g>, [">= 1.7.2", "~> 1.7"])
      s.add_dependency(%q<code>, ["~> 0.9"])
      s.add_dependency(%q<ori>, ["~> 0.1.0"])
      s.add_dependency(%q<methodfinder>, ["~> 2.0"])
      s.add_dependency(%q<method_locator>, [">= 0.0.4", "~> 0.0"])
      s.add_dependency(%q<ruby_version>, ["~> 1.0"])
      s.add_dependency(%q<ruby_engine>, ["~> 1.0"])
      s.add_dependency(%q<ruby_info>, ["~> 1.0"])
      s.add_dependency(%q<os>, ["~> 0.9"])
      s.add_dependency(%q<instance>, ["~> 0.2"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 3.2"])
    s.add_dependency(%q<rake>, ["~> 10.4"])
    s.add_dependency(%q<every_day_irb>, ["~> 2.0"])
    s.add_dependency(%q<fancy_irb>, ["~> 1.0"])
    s.add_dependency(%q<wirb>, ["~> 2.0"])
    s.add_dependency(%q<hirb>, [">= 0.7.3", "~> 0.7"])
    s.add_dependency(%q<binding.repl>, ["~> 3.0"])
    s.add_dependency(%q<paint>, ["< 2.0", ">= 0.9"])
    s.add_dependency(%q<clipboard>, [">= 1.0.6", "~> 1.0"])
    s.add_dependency(%q<interactive_editor>, [">= 0.0.10", "~> 0.0"])
    s.add_dependency(%q<coderay>, ["~> 1.1"])
    s.add_dependency(%q<debugging>, ["~> 1.1"])
    s.add_dependency(%q<g>, [">= 1.7.2", "~> 1.7"])
    s.add_dependency(%q<code>, ["~> 0.9"])
    s.add_dependency(%q<ori>, ["~> 0.1.0"])
    s.add_dependency(%q<methodfinder>, ["~> 2.0"])
    s.add_dependency(%q<method_locator>, [">= 0.0.4", "~> 0.0"])
    s.add_dependency(%q<ruby_version>, ["~> 1.0"])
    s.add_dependency(%q<ruby_engine>, ["~> 1.0"])
    s.add_dependency(%q<ruby_info>, ["~> 1.0"])
    s.add_dependency(%q<os>, ["~> 0.9"])
    s.add_dependency(%q<instance>, ["~> 0.2"])
  end
end
