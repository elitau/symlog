require File.dirname(__FILE__) + '/../test_helper'

class DescriptionTest < ActiveSupport::TestCase

  include Symlog
  
  def test_should_create_description
    d = Description.new(description_name, [:direction], 10)
    assert_equal description_name, d.name
    assert_equal [:direction], d.directions
    assert_equal 10, d.value
  end
  
  def test_should_return_all_descriptions
    all_desc = Description.all
    assert_kind_of Description, all_desc.first
    assert_equal 26, all_desc.size
  end
  
  def test_should_have_upward_descriptions
    upward = Description.upward_descriptions
    assert_equal 9, upward.size
    assert upward.all?{|desc| desc.directions.include?(:upward)}
    others = Description.all - upward
    assert others.all?{|desc| !desc.directions.include?(:upward)}
  end
  
  def test_description_collection
    all_desc = Description.all
    all_desc.extend Symlog::DescriptionCollection
    
    assert_respond_to all_desc, :upward_descriptions
    
    upward = all_desc.upward_descriptions
    assert_equal 9, upward.size
    assert upward.all?{|desc| desc.directions.include?(:upward)}
    others = all_desc - upward
    assert others.all?{|desc| !desc.directions.include?(:upward)}
    
    assert_respond_to all_desc, :downward_descriptions
    
    downward = all_desc.downward_descriptions
    assert_equal 9, downward.size
    assert downward.all?{|desc| desc.directions.include?(:downward)}
    others = all_desc - downward
    assert others.all?{|desc| !desc.directions.include?(:downward)}
  end
    
  def description_name
    DESCRIPTIONS.first.keys.first
  end

end