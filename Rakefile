require 'rake'
require 'rake/testtask'
require 'rake/gempackagetask'
require 'rake/rdoctask'

spec = Gem::Specification.new do |s|
  s.name = 'validation_group'
  s.version = '0.1.2'
  s.platform = Gem::Platform::RUBY
  s.description = 'Validation groups for ActiveRecord'
  s.summary = 'Validation groups for ActiveRecord'
  
  s.files = FileList['{lib,test,tasks}/**/*'] + %w(CHANGELOG.rdoc init.rb install.rb uninstall.rb MIT-LICENSE Rakefile README .gitignore) - FileList['**/*.log']
  s.require_path = 'lib'
  s.has_rdoc = true
  s.test_files = Dir['test/*_test.rb']
  
  s.author = 'Alex Kira'
  s.email = ''
  s.homepage = 'http://github.com/akira/validationgroup/tree/master'
end

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the validation_group plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the validation_group plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'ValidationGroup'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README', 'CHANGELOG.rdoc', 'MIT-LICENSE')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Generate a gemspec file.'
task :gemspec do
  File.open("#{spec.name}.gemspec", 'w') do |f|
    f.write spec.to_ruby
  end
end
 
Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
end

Dir['tasks/**/*.rake'].each {|rake| load rake}
