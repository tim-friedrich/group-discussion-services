# -*- encoding: utf-8 -*-
# stub: jquery.fileupload-rails 1.11.0 ruby lib

Gem::Specification.new do |s|
  s.name = "jquery.fileupload-rails"
  s.version = "1.11.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Semyon Perepelitsa"]
  s.date = "2014-10-25"
  s.description = "This gem packages jQuery File Upload plugin and it's dependencies for Rails asset pipeline."
  s.email = "sema@sema.in"
  s.homepage = "https://github.com/semaperepelitsa/jquery.fileupload-rails"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.6"
  s.summary = "Use jQuery File Upload plugin with Rails 3"

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, [">= 3.1"])
      s.add_runtime_dependency(%q<jquery-ui-rails>, ["~> 5.0"])
    else
      s.add_dependency(%q<railties>, [">= 3.1"])
      s.add_dependency(%q<jquery-ui-rails>, ["~> 5.0"])
    end
  else
    s.add_dependency(%q<railties>, [">= 3.1"])
    s.add_dependency(%q<jquery-ui-rails>, ["~> 5.0"])
  end
end
