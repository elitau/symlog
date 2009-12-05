class Person
  attr_reader :surveys, :name
  
  def initialize(name, surveys)
    @name = name
    @surveys = surveys
  end
  
  def dimensions
    @dimensions ||= calculate_dimensions
    return @dimensions
  end
  
  def calculate_dimensions
    @dimensions = []
    Symlog::Dimension.all.each do |d|
      @dimensions << Symlog::Dimension.new(d.name)
    end
    
    self.surveys.each do |survey|
      @dimensions.each do |dimension|
        dimension + survey.dimensions.find{|d| d.name == dimension.name}
      end
    end
    return @dimensions
  end
  
  def self.find_all
    surveys = Survey.find_all
    people = []
    names = surveys.collect(&:described_person).uniq
    names.each do |name|
      people << Person.new(name, surveys.find_all{|s| s.described_person == name})
    end
    return people
  end
end
    