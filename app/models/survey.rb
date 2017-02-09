class Survey

  include Mongoid::Document
  include SymlogModel

  field :described_person,     type: String
  field :person_who_describes, type: String

  # Person descriptions
  Description.names.each do |name|
    field name, type: Integer
  end

  # view :all, :key => :created_at

  POSSIBLE_RATINGS = [0,1,2,3,4]

  PEOPLE_TO_DESCRIBE = %w(Andi Andreas Björn Dirk Ede Ethem Mike )

  def self.find_all
    # CouchPotato.database.view all
    all
  end

  def self.count
    find_all.size
  end

  # def save
  #   CouchPotato.database.save_document self
  # end

  # def self.find(id)
  #   CouchPotato.database.load_document id.to_s
  # end

  def descriptions
    @descriptions ||= Description.create_all_from_survey(self)
  end

  def dimensions
    @dimension_values ||= DIMENSIONS.collect do |name, directions|
      Dimension.new(name, directions, self.send("#{name}_value"))
    end
  end

end
