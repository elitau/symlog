require File.dirname(__FILE__) + '/../test_helper'

class PersonTest < ActiveSupport::TestCase

  include Symlog
  
  def test_should_have_upward_value
    descriptions = some_descriptions
    p = Person.new(descriptions)
    assert_equal descriptions, p.descriptions
    assert_equal 0, p.upward_value
  end
  
  def test_should_have_positive_value
    descriptions = some_descriptions
    p = Person.new(descriptions)
    assert_equal descriptions, p.descriptions
    assert_equal 20, p.positive_value
  end
  
  def test_should_have_upward_downward_value
    descriptions = [Description.new(:name, [:upward], 10)]
    p = Person.new(descriptions)
    assert_equal descriptions, p.descriptions
    assert_equal descriptions, p.descriptions.upward_descriptions
    assert_equal 5, p.upward_downward_value
  end

  def test_should_have_positive_negative_value
    descriptions = some_descriptions
    p = Person.new(descriptions)
    assert_equal descriptions, p.descriptions
    assert_equal descriptions.last, p.descriptions.negative_descriptions.first
    assert_equal 9.5, p.positive_negative_value
  end
  
  def test_should_have_forward_backward_value
    descriptions = [Description.new(:name, [:forward], 20), Description.new(:name, [:downward], 10)]
    p = Person.new(descriptions)
    assert_equal descriptions, p.descriptions
    assert_equal descriptions.first, p.descriptions.forward_descriptions.first
    assert_equal 10, p.forward_backward_value
  end
  
  def some_descriptions
    descriptions = [
      Description.new(:name, [:forward], 3000),
      Description.new(:name, [:positive, :forward], 10), 
      Description.new(:amen, [:positive], 10), 
      Description.new(:name, [:negative], 1)
    ]
  end
  

end