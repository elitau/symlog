module Symlog
  DIRECTIONS = [:upward, :downward, :positive, :negative, :forward, :backward]
  DIMENSIONS = {
    :upward_downward => DIRECTIONS[0,2],
    :positive_negative => DIRECTIONS[2,2], 
    :forward_backward => DIRECTIONS[4,2]
  }
  DESCRIPTIONS = [
    {:aktiv             => [:upward]},
    {:extravertiert     => [:upward, :positive]},
    {:zielbewusst       => [:upward, :positive, :forward]},
    {:tatkraeftig       => [:upward, :forward]},
    {:disziplinierend   => [:upward, :negative, :forward]},
    {:dominant          => [:upward, :negative]},
    {:geltungssuchend   => [:upward, :negative, :backward]},
    {:macht_spaesse     => [:upward, :backward]},
    {:optimitstisch     => [:upward, :positive, :backward]},
    {:freundlich        => [:positive]},
    {:interessiert      => [:positive, :forward]},
    {:analytisch        => [:forward]},
    {:kritisch          => [:negative, :forward]},
    {:unfreundlich      => [:negative]},
    {:uninteressiert    => [:negative, :backward]},
    {:emotional         => [:backward]},
    {:warmherzig        => [:positive, :backward]},
    {:verstaendnisvoll  => [:downward, :positive]},
    {:ruecksichtnehmend => [:downward, :positive, :forward]},
    {:besonnen          => [:downward, :forward]},
    {:selbstkritisch    => [:downward, :negative, :forward]},
    {:traurig           => [:downward, :negative]},
    {:entmutigt         => [:downward, :negative, :backward]},
    {:unentschlossen    => [:downward, :backward]},
    {:behaglich         => [:downward, :positive, :backward]},
    {:passiv            => [:downward]}
  ]

  class Chart
    
    def initialize(dimensions)
      @dimensions = dimensions
    end
    
    def self.url(dimensions)
      ""
    end
    
  end

  class Dimension
    attr_reader :name, :value
    def initialize(name, directions, value)
      @name = name
      @value = value
    end
    
    def self.all
      @all_dimensions ||= DIMENSIONS.collect do |name, directions|
        self.class.new(name)
      end
      return @all_dimensions
    end
  end
  
  class Description
    attr_reader :name, :value, :directions
    
    def initialize(name, directions, value = nil)
      @name = name
      @directions = directions
      @value = value.to_i
    end
    
    def self.create_all_from_survey(survey)
      DESCRIPTIONS.collect do |desc|
        self.new(name = desc.keys.first, desc.values.first, survey.send(name))
      end.extend DescriptionCollection
    end
        
    def self.all
      @all_desc ||= DESCRIPTIONS.collect do |desc|
        self.new(desc.keys.first, desc.values.first)
      end.extend DescriptionCollection
      return @all_desc
    end
    
    def self.names
      @names ||= DESCRIPTIONS.collect do |desc|
        desc.keys.first
      end
    end
    
    DIRECTIONS.each do |dimension|
      self.instance_eval %Q{
          def #{dimension}_descriptions
            @#{dimension}_desc = self.all.collect do |desc|
              desc.directions.include?(:#{dimension}) ? desc : nil
            end.compact
            return @#{dimension}_desc
          end
        }
    end
    
  end
  
  module DescriptionCollection
    DIRECTIONS.each do |direction|
      self.class_eval %Q{
          def #{direction}_descriptions
            @#{direction}_desc = self.collect do |desc|
              desc.directions.include?(:#{direction}) ? desc : nil
            end.compact
            return @#{direction}_desc
          end
        }
    end
  end
  
  class Person
    attr_accessor :descriptions
    attr_accessor :name
    attr_accessor :surveys
    
    def initialize(descriptions)
      @descriptions = descriptions
    end
  end
    
  module InstanceMethods
    DIMENSIONS.each do |name, directions|
      first = directions.first
      last = directions.last
      class_eval %Q{
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
  
  def self.included(receiver)
    receiver.send :include, InstanceMethods
  end
end
