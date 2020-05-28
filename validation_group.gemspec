# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "validation_group"
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alex Kira"]
  s.date = "2012-02-06"
  s.description = "Validation groups for ActiveRecord"
  s.email = ""
  s.files = ["lib/validation_group.rb", "test/database.yml", "test/schema.rb", "test/test_helper.rb", "test/validation_group_test.rb", "tasks/validation_group_tasks.rake", "CHANGELOG.rdoc", "init.rb", "install.rb", "uninstall.rb", "MIT-LICENSE", "Rakefile", "README", ".gitignore"]
  s.homepage = "http://github.com/akira/validationgroup/tree/master"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.15"
  s.summary = "Validation groups for ActiveRecord"
  s.test_files = ["test/validation_group_test.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
