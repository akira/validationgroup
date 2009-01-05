require 'validation_group'

ActiveRecord::Base.send(:extend, ValidationGroup::ActiveRecord::ActsMethods)
ActiveRecord::Errors.send :include, ValidationGroup::ActiveRecord::Errors
