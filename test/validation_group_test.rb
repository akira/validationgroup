require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))

class ValidationGroupModel < ActiveRecord::Base
  validates_presence_of :name, :description, :address, :email
  
  validation_group :step1, :fields=>[:name, :description]
  validation_group :step2, :fields=>[:address]     
end

class PlainModel < ActiveRecord::Base
  validates_presence_of :name
end

class ValidationGroupTest < Test::Unit::TestCase
  def test_validation_group_names_appear_in_order
    order = ValidationGroupModel.validation_group_order
    assert_not_nil order
    assert_equal 2, order.size
    assert_equal :step1, order[0]
    assert_equal :step2, order[1]
  end
	
  def test_validation_group_fields_for_names
    names = ValidationGroupModel.validation_group_order
    groups = ValidationGroupModel.validation_groups
    assert_not_nil groups
    fields = groups[names[0]]
    assert_equal 2, fields.size
    assert fields.include?(:name)
    assert fields.include?(:description)
    fields = groups[names[1]]
    assert_equal 1, fields.size
    assert fields.include?(:address)
  end
	
  def test_validation_no_groups_fail
    @model = ValidationGroupModel.new
    assert !@model.valid?
    assert_equal 4, @model.errors.size    
  end
  
  def test_validation_group1_fail
    @model = ValidationGroupModel.new
    @model.enable_validation_group :step1
    assert !@model.valid?
    assert_equal 2, @model.errors.size    
  end

  def test_validation_group1_add_error
    @model = ValidationGroupModel.new(:name=>"Name", :description=>"Description")
    @model.enable_validation_group :step1
    @model.errors.add(:name, "Name is invalid")
    assert !@model.errors.blank?
  end

  def test_validation_group1_add_error_empty_msg
    @model = ValidationGroupModel.new(:name=>"Name", :description=>"Description")
    @model.enable_validation_group :step1
    @model.errors.add(:name)
    assert !@model.errors.blank?
  end

  def test_validation_group1_pass
    @model = ValidationGroupModel.new(:name=>"Name", :description=>"Description")
    @model.enable_validation_group :step1
    assert @model.valid?
    assert_equal 0, @model.errors.size    
    @model.save!
  end
  
  def test_validation_group2_fail
    @model = ValidationGroupModel.new
    @model.enable_validation_group :step2
    assert !@model.valid?
    assert_equal 1, @model.errors.size
  end

  def test_validation_clear_group_fail
    @model = ValidationGroupModel.new
    @model.enable_validation_group :step1
    assert !@model.valid?
    assert_equal 2, @model.errors.size        
    @model.disable_validation_group
    assert !@model.valid?
    assert_equal 4, @model.errors.size    
  end  
  
  def test_validation_group_invalid
    @model = ValidationGroupModel.new
    assert_raise ArgumentError do 
      @model.enable_validation_group :invalid
    end    
  end    
	
  def test_should_validate_no_groups
    @model = ValidationGroupModel.new
    assert @model.should_validate?(:name)
    assert @model.should_validate?(:description)
    assert @model.should_validate?(:address)
    assert @model.should_validate?(:email)
  end
	
  def test_should_validate_group1
    @model = ValidationGroupModel.new
    @model.enable_validation_group(:step1)
    assert @model.should_validate?(:name)
    assert @model.should_validate?(:description)
    assert !@model.should_validate?(:address)
    assert !@model.should_validate?(:email)
  end

  def test_valid_query_sets_current
    @model = ValidationGroupModel.new
    @model.valid?(:step2)
    assert_equal :step2, @model.current_validation_group
    @model.valid?(:step1)
    assert_equal :step1, @model.current_validation_group
  end
	
  def test_valid_group1_fails
    @model = ValidationGroupModel.new
    assert !@model.valid?(:step1)
  end
	
  def test_valid_group1_passes_and_group2_fails_then_passes
    @model = ValidationGroupModel.new
    @model.name = 'MyModel'
    @model.description = 'My model'
    assert @model.valid?(:step1)
    assert !@model.valid?(:step2)
    @model.address = 'uri:my_model'
    assert @model.valid?
  end
  
  def test_validation_for_models_without_validation_group
    @model = PlainModel.new
    assert !@model.valid?
    assert_equal 1, @model.errors.size
  end  	
end
