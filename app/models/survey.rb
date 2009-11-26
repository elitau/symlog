class Survey
  
  include CouchPotato::Persistence
  include Symlog
  
  property :described_person
  
  # Person descriptions
  Description.all.each do |description|
    property description.name
  end
  
  view :all, :key => :created_at
  
  POSSIBLE_RATINGS = {
    :nie      => 0,
    :selten   => 1,
    :manchmal => 2,
    :haeufig  => 3,
    :immer    => 4
  }
  
  after_save :calculate_influence_values
  
  def self.find_all
    CouchPotato.database.view all
  end
  
  def save
    CouchPotato.database.save_document self
  end
  
  def self.find(id)
    CouchPotato.database.load_document id.to_s
  end
  
  DIMENSIONS.each do |name, directions|
    first = directions.first
    last = directions.last
    self.class_eval %Q{
      #{
        direction_methods = directions.collect do |direction|
          %Q{
            def #{direction}_value
              descriptions.#{direction}_descriptions.collect(&:value).compact.sum
            end
          }
        end
        direction_methods
      }
    
      def #{name}_value
        (#{first}_value - #{last}_value)/2.0
      end
    }
  end
  
end
