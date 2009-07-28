# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{validation_group}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alex Kira"]
  s.date = %q{2009-07-27}
  s.description = %q{Validation groups for ActiveRecord}
  s.email = %q{}
  s.files = ["lib/validation_group.rb", "test/test_helper.rb", "test/validation_group_test.rb", "tasks/validation_group_tasks.rake", "CHANGELOG.rdoc", "init.rb", "install.rb", "uninstall.rb", "MIT-LICENSE", "Rakefile", "README", ".gitignore"]
  s.homepage = %q{http://github.com/akira/validationgroup/tree/master}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{Validation groups for ActiveRecord}
  s.test_files = ["test/validation_group_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
