require 'test_helper'

class SurveyTest < ActiveSupport::TestCase

  def test_should_calculate_dimensions
    survey = Survey.new
    survey.expects(:calculate_influence_value)
    survey.expects(:calculate_friendly_value)
    survey.expects(:calculate_emotional_value)
    survey.calculate_dimensions
  end
  
  def test_should_calculate_emotional_value
    survey = create_survey
    
  end
  
  def create_survey(attributes = {})
    default_value = Survey::POSSIBLE_RATINGS.values.first
    default_attributes = {}
    Survey.person_descriptions.each do |name|
      default_attributes.merge!({name => default_value})
    end
    Survey.new(default_attributes.merge(attributes))
  end
  
  
end
