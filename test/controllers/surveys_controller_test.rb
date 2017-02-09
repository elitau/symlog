require 'test_helper'

class SurveysControllerTest < ActionController::TestCase
  def setup
    @survey = create_survey
  end

  test "should get index" do
    get :index
    assert_response :success
    # assert_not_nil assigns(:surveys)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create survey" do
    get :new # Create session
    post :create, params: { survey: @survey.attributes }
    # @survey = assigns :survey
    assert_redirected_to survey_path(Survey.last)
  end

  # test "should show survey" do
  #   puts @survey.inspect
  #   get :show, :id => @survey.id
  #   assert_response :success
  # end

  # def teardown
  #   CouchPotato.database.destroy_document @survey if @survey._id
  # end
end
