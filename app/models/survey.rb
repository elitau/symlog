class Survey

  include Mongoid::Document
  include SymlogModel

  field :described_person,     type: String
  field :person_who_describes, type: String

  # Person descriptions
  Description.names.each do |name|
    field name, type: Integer
  end

  validates *Description.names, presence: true
  validates :described_person, :person_who_describes, presence: true

  POSSIBLE_RATINGS = [0,1,2,3,4]

  PEOPLE_TO_DESCRIBE = %w(Alice Bob Mike George)

  def self.find_all
    all
  end

  def descriptions
    @descriptions ||= Description.create_all_from_survey(self)
  end

  def dimensions
    @dimension_values ||= DIMENSIONS.collect do |name, directions|
      Dimension.new(name, directions, self.send("#{name}_value"))
    end
  end

end
