ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def create_survey(attributes = {})
    default_value = Survey::POSSIBLE_RATINGS.first
    default_attributes = {
      :macht_spaesse     => "10".to_i, #[:upward, :backward]},
      :optimitstisch     => "2".to_i, #[:upward, :positive, :backward]},
      :freundlich        => "3".to_i, #[:positive]},
      :interessiert      => "4".to_i, #[:positive, :forward]},
      :verstaendnisvoll  => "1".to_i, #[:downward, :positive]},
      :ruecksichtnehmend => "1".to_i  #[:downward, :positive, :forward]},
    }

    # upward_downward_value => (macht_spaesse + optimitstisch - verstaendnisvoll - ruecksichtnehmend)/2.0 = 0.5

    # Symlog::Description.names.each do |name|
    #   default_attributes.merge!({name => default_value})
    # end
    Survey.new(default_attributes.merge(attributes))
  end
end
