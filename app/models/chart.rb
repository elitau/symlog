class Chart
  
  def initialize(dimensions)
    @dimensions = dimensions
  end
  
  def render_for_js
    @dimensions.inspect
  end
  
end