$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'rubygems'

gem 'activerecord', ENV['AR_VERSION'] ? "=#{ENV['AR_VERSION']}" : '>=2.1.0'
require 'active_record'
require 'test/unit'
require 'validation_group'

ActiveRecord::Base.establish_connection({'adapter' => 'sqlite3', 'database' => ':memory:'})
ActiveRecord::Base.logger = Logger.new("#{File.dirname(__FILE__)}/active_record.log")

connection = ActiveRecord::Base.connection
connection.create_table(:validation_group_models, :force=>true) do |t|
	t.string :name
	t.string :description
	t.string :address
	t.string :email
end

