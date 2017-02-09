require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  include SymlogModel

  def test_should_have_descriptions
    survey = create_survey
    assert descriptions = survey.descriptions
    assert_equal 26, descriptions.size
  end

  def test_should_calculate_dimensions
    survey = create_survey

    dimensions = survey.dimensions
    assert_equal 3, dimensions.size
    assert_kind_of Dimension, ud = dimensions.find{|d| d.name == :upward_downward}
    assert_equal 5, ud.value
  end

  def test_should_have_upward_value
    # descriptions = some_descriptions
    survey = create_survey
    assert_equal 12, survey.upward_value
  end

  def test_should_have_positive_value
    survey = create_survey
    assert descriptions = survey.descriptions
    assert_equal 11, survey.positive_value
  end

  def test_should_have_upward_downward_value
    survey = create_survey
    assert descriptions = survey.descriptions
    assert_equal 9, survey.descriptions.upward_descriptions.size
    assert_equal 5, survey.upward_downward_value
  end

  def test_should_have_positive_negative_value
    survey = create_survey
    assert descriptions = survey.descriptions
    assert_equal 5.5, survey.positive_negative_value
  end

  def test_should_have_forward_backward_value
    survey = create_survey
    assert survey.descriptions
    assert_equal -3.5, survey.forward_backward_value
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
