module ValidationGroup
  module ActiveRecord
    module ActsMethods # extends ActiveRecord::Base
      def self.extended(base)
        # Add class accessor which is shared between all models and stores
        # validation groups defined for each model
        base.class_eval do
          cattr_accessor :validation_group_classes
          self.validation_group_classes = {}
        end
      end

      def validation_group(name, options={})
        self_groups = (self.validation_group_classes[self] ||= {})
        self_groups[name] = options[:fields] || []

        unless included_modules.include?(InstanceMethods)
          attr_reader :current_validation_group
          include InstanceMethods
        end
      end
    end

    module InstanceMethods # included in every model which calls validation_group
      def enable_validation_group(group)
        # Check if given validation group is defined for current class
        # or one of its ancestors
        group_classes = self.class.validation_group_classes
        found = ValidationGroup::Util.current_and_ancestors(self.class).
                  find do |klass|
                    group_classes[klass] &&
                    group_classes[klass].include?(group)
                  end
        if found
          @current_validation_group = group
        else
          raise ArgumentError, "No validation group of name #{group}"
        end
      end

      def disable_validation_group
        @current_validation_group = nil
      end

      def validation_group_enabled?
        respond_to?(:current_validation_group) && !current_validation_group.nil?
      end
    end

    module Errors # included in ActiveRecord::Errors
      def add_with_validation_group(attribute,
                                    msg = @@default_error_messages[:invalid], *args,
                                    &block)
        add_error = true
        if @base.validation_group_enabled?
          current_group = @base.current_validation_group
          found = ValidationGroup::Util.current_and_ancestors(@base.class).
            find do |klass|
              klasses = klass.validation_group_classes
              klasses[klass] && klasses[klass][current_group] &&
              klasses[klass][current_group].include?(attribute)
            end
          add_error = false unless found
        end
        add_without_validation_group(attribute, msg, *args,&block) if add_error
      end

      def self.included(base) #:nodoc:
        base.class_eval do
          alias_method_chain :add, :validation_group
        end
      end
    end
  end

  module Util
    # Return array of consisting of current and its superclasses
    # down to and including base_class.
    def self.current_and_ancestors(current)
      returning [] do |klasses|
        klasses << current
        root = current.base_class
        until current == root
          current = current.superclass
          klasses << current
        end
      end
    end
  end
end