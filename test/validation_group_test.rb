require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))

class ValidationGroupModel < ActiveRecord::Base
  validates_presence_of :name, :description, :address, :email
  
  validation_group :step1, :fields=>[:name, :description]
  validation_group :step2, :fields=>[:address]     
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
end
