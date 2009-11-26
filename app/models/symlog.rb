module Symlog
  DIRECTIONS = [:upward, :downward, :positive, :negative, :forward, :backward]
  DIMENSIONS = {
    :upward_downward => DIRECTIONS[0,2],
    :positive_negative => DIRECTIONS[2,2], 
    :forward_backward => DIRECTIONS[4,2]
  }
  
  class Description
    attr_reader :name, :value, :directions
    
    def initialize(name, directions, value = nil)
      @name = name
      @directions = directions
      @value = value
    end
        
    def self.all
      @all_desc ||= DESCRIPTIONS.collect do |desc|
        self.new(desc.keys.first, desc.values.first)
      end
      return @all_desc
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
      @descriptions = descriptions.extend DescriptionCollection
    end

  end
  
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
end