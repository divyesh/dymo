class VisitsController < ApplicationController
  before_action :set_visit, only: [:show, :edit, :update, :destroy]
  before_action :set_patient, only: [:new, :create, :edit, :update]
  before_action :set_tests, only: [:new, :create, :edit, :update]

  def index
    if params[:healthcard] && params[:healthcard].length >= 50
      options = parse_healthcard(params[:healthcard])

      patient = Patient.find_by_healthnumber(options[:healthnumber])

      if patient
        patient.health_expiry_date = options[:health_expiry_date]
        patient.version_code = options[:version_code]
        patient.save
        redirect_to new_patient_visit_path(patient)
      else
        patient = Patient.create(options)
        if patient.errors.any?
          redirect_to new_patient_path(patient)
        else
          redirect_to new_patient_visit_path(patient)
        end
      end
    else
      @visits = Visit.search(params[:healthcard]).order("created_at desc").paginate(:per_page => 25, :page => params[:page])

      respond_to do |format|
        format.html
        format.json { render json: @visits }
        format.xml  { render xml: @visits }
      end
    end
  end

  def show
  end

  def new
    @visit = @patient.visits.new
    authorize! :new, @visit
    @visit.visitdate = DateTime.now
    @tests = Test.all.to_a
    @test_groups = @tests.group_by { |t| t.test_group }
  end

  def edit
    authorize! :edit, @visit
  end

  def create
    @visit = @patient.visits.new(visit_params)
    authorize! :create, @visit
    @visit.visitdate = DateTime.now

    respond_to do |format|
      if @visit.save
        token = @visit.patient.time_in_token
        token.add_visit! if token

        format.html { redirect_to(@patient, notice: 'Visit was successfully created and token time registered.') }
        format.json  { render json: @visit, status: :created, location: @visit }
        format.xml  { render xml: @visit, status: :created, location: @visit }
      else
        format.html { render action: "new" }
        format.json  { render json: @visit.errors, status: :unprocessable_entity }
        format.xml  { render xml: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize! :update, @visit

    respond_to do |format|
      if @visit.update_attributes(visit_params)
        format.html { redirect_to(@patient, notice: 'Visit was successfully updated.') }
        format.json  { head :no_content }
        format.xml  { head :no_content }
      else
        format.html { render action: "edit" }
        format.json  { render json: @visit.errors, status: :unprocessable_entity }
        format.xml  { render xml: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize! :destroy, @visit
    @visit.destroy

    respond_to do |format|
      format.html { redirect_to(visits_url, notice: 'Visit was successfully destroyed.') }
      format.xml  { head :ok }
    end
  end

  private
    def set_visit
      @visit = Visit.find(params[:id])
    end

    def set_patient
      @patient = Patient.find(params[:patient_id])
    end

    def visit_params
      params.require(:visit).permit(:patient_id, :physician_id, :visitdate, :payment_program, :specimen_priority, :amount, test_ids: [])
    end

    def set_tests
      @tests = Test.all.to_a
      @test_groups = @tests.group_by { |t| t.test_group }
    end
end
