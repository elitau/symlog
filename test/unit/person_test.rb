require File.dirname(__FILE__) + '/../test_helper'

class PersonTest < ActiveSupport::TestCase

  def test_should_have_dimensions
    first_survey = create_survey
    second_survey = create_survey
    surveys = [first_survey, second_survey]
    person = Person.new("described_person", surveys)
    assert dimensions = person.dimensions
    assert_equal 3, dimensions.size
    expected_value = first_survey.dimensions.find{|d| d.name == :upward_downward}.value + 
      second_survey.dimensions.find{|d| d.name == :upward_downward}.value
    assert_equal expected_value, dimensions.find{|d| d.name == :upward_downward}.value
  end
  

end