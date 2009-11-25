class Survey
  include CouchPotato::Persistence
  
  property :described_person
  
  # Person descriptions
  property :aktiv
  property :extravertiert
  property :zielbewusst
  property :tatkräftig
  property :disziplinierend
  property :dominant
  property :geltungssuchend
  property :macht_spaesse
  property :optimitstisch
  property :freundlich
  property :interessiert
  property :analytisch
  property :kritisch
  property :unfreundlich
  property :uninteressiert
  property :emotional
  property :warmherzig
  property :verstaendnisvoll
  property :ruecksichtnehmend
  property :besonnen
  property :selbstkritisch
  property :traurig
  property :entmutigt
  property :unentschlossen
  property :behaglich
  property :passiv

  cattr_accessor :person_descriptions
  self.person_descriptions = property_names - [:created_at, :updated_at, :described_person]
  
  person_descriptions.each do |prop|
    validates_numericality_of prop, :if => lambda { prop.nil? }
  end
  
  view :all, :key => :created_at
  
  POSSIBLE_RATINGS = [:nie, :selten, :manchmal, :häufig, :immer]
  
  
  def self.find_all
    CouchPotato.database.view all
  end
  
  def save
    CouchPotato.database.save_document self
  end
  
  def self.find(id)
    CouchPotato.database.load_document id.to_s
  end
  
end
