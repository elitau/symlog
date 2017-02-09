require 'test_helper'

class DimensionTest < ActiveSupport::TestCase
  include SymlogModel

  def test_should_sum_dimension
    dimension = Dimension.new("name", "directions", 10)
    another_dimension = Dimension.new("name", "directions", -2)
    sum_dimension = dimension + another_dimension
    assert_equal 8, sum_dimension.value
  end

end
