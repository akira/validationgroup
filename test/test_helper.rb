$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'rubygems'

gem 'activerecord', ENV['AR_VERSION'] ? "=#{ENV['AR_VERSION']}" : '>=2.1.0'
require 'active_record'
require 'test/unit'
require 'validation_group'

# jeffp: removed fixture loading code - unnecessary 
# jeffp: removed environment.rb reference for gemification purposes 
# jeffp: added code to test in sqlite memory database - speedy tests

db_adapter = ENV['DB'] || begin
  require 'rubygems'
  require 'sqlite'
  'sqlite'
rescue MissingSourceFile
  begin
    require 'sqlite3'
    'sqlite3'
  rescue MissingSourceFile
  end
end

if db_adapter.nil?
  raise "No DB Adapter selected. Pass the DB= to pick one, or install Sqlite or Sqlite3."
end

ActiveRecord::Base.establish_connection({'adapter' => db_adapter, 'database' => ':memory:'})
#ActiveRecord::Base.logger = Logger.new("#{File.dirname(__FILE__)}/active_record.log")

connection = ActiveRecord::Base.connection
connection.create_table(:validation_group_models, :force=>true) do |t|
  t.string :name
  t.string :description
  t.string :address
  t.string :email
end
connection.create_table(:user, :force=>true) do |t|
  t.string :first_name
  t.string :last_name
  t.string :username
end

class User < ActiveRecord::Base
  validation_group :step1, :fields=>[:first_name, :last_name]
  validation_group :step2, :fields=>[:username]
end
 