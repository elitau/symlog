class SurveysController < ApplicationController
  # GET /surveys
  # GET /surveys.xml
  def index
    # @surveys = Survey.find_all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @surveys }
    end
  end

  # GET /surveys/1
  # GET /surveys/1.xml
  def show
    @survey = Survey.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @survey }
    end
  end

  def chart
    @people = Person.find_all
  end

  # GET /surveys/new
  # GET /surveys/new.xml
  def new
    @survey = Survey.new
    @people_to_describe = people_to_describe
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @survey }
    end
  end

  # POST /surveys
  # POST /surveys.xml
  def create
    @survey = Survey.new(surveys_params)
    session[:person_who_describes] = @survey.person_who_describes

    respond_to do |format|
      if @survey.save
        flash[:notice] = 'Survey was successfully created.'
        session[:already_described_person] << @survey.described_person
        format.html { redirect_to(@survey) }
      else
        @people_to_describe = people_to_describe
        format.html { render action: "new" }
      end
    end
  end

  private

  def surveys_params
    params.require(:survey).permit([*SymlogModel::Description.names, :described_person, :person_who_describes]) #.permit()
  end

  def people_to_describe
    Survey::PEOPLE_TO_DESCRIBE - (session[:already_described_person] ||= [])
  end

end
