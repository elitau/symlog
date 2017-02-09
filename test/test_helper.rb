ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...
  def create_survey(attributes = {})
    default_value = Survey::POSSIBLE_RATINGS.first
    default_attributes = {
      :macht_spaesse     => 10, #[:upward, :backward]},
      :optimitstisch     => 2,  #[:upward, :positive, :backward]},
      :freundlich        => 3,  #[:positive]},
      :interessiert      => 4,  #[:positive, :forward]},
      :verstaendnisvoll  => 1,  #[:downward, :positive]},
      :ruecksichtnehmend => 1   #[:downward, :positive, :forward]},
    }

    # upward_downward_value => (macht_spaesse + optimitstisch - verstaendnisvoll - ruecksichtnehmend)/2.0 = 0.5

    SymlogModel::Description.names.each do |name|
      default_attributes.reverse_merge!({name => default_value})
    end
    Survey.new(default_attributes.merge(attributes))
  end
end
