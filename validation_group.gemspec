# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "validation_group"
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alex Kira"]
  s.date = "2012-02-06"
  s.description = "Validation groups for ActiveRecord"
  s.email = ""
  s.files = ["lib/validation_group.rb", "test/database.yml", "test/schema.rb", "test/test_helper.rb", "test/validation_group_test.rb", "tasks/validation_group_tasks.rake", "CHANGELOG.rdoc", "init.rb", "install.rb", "uninstall.rb", "MIT-LICENSE", "Rakefile", "README", ".gitignore"]
  s.homepage = "http://github.com/akira/validationgroup/tree/master"
  s.require_paths = ["lib"]
  s.summary = "Validation groups for ActiveRecord"
  s.test_files = ["test/validation_group_test.rb"]

  s.add_runtime_dependency 'activerecord', '> 5.2', '< 8'
  s.add_development_dependency 'bundler', '> 1.17'
  s.add_development_dependency 'rake', '> 0.8'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'test-unit'

end
