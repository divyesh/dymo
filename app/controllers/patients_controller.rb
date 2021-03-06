class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  def index
    @patients = Patient.search(params[:search]).order("created_at desc").paginate(per_page: 5, page: params[:page])
  end

  def show
  end

  def new
    @patient = params[:patient].nil? ? Patient.new : Patient.new(patient_params)
    authorize! :new, @patient
    @tests = Test.all.to_a
    @test_groups = @tests.group_by { |t| t.test_group }
  end

  def edit
  end

  def create
    @patient = Patient.new(patient_params)
    authorize! :create, @patient

    respond_to do |format|
      if @patient.save
        @token = @patient.new_time_in_token(current_user, current_location)

        print_token

        #Visit.create({ physician_id: params[:physician_id1], patient_id: @patient.id, visitdate: params[:visitdate], payment_program: params[:payment_program], test_ids: params[:test_ids] })

        format.html { redirect_to(location_tokens_path(current_location), notice: 'Patient and Token were successfully created.') }
        format.json  { render json: @patient, status: :created, location: @patient }
        format.xml  { render xml: @patient, status: :created, location: @patient }
      else
        format.html { render action: "new" }
        format.json  { render json: @patient.errors, status: :unprocessable_entity }
        format.xml  { render xml: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @patient = Patient.find(params[:id])
    authorize! :create, @patient

    respond_to do |format|
      if @patient.update_attributes(patient_params)
        format.html { redirect_to(@patient, notice => 'Patient was successfully updated.') }
        format.json  { head :no_content }
        format.js
        format.xml  { head :no_content }
      else
        format.html { render action: "edit" }
        format.json  { render json: @patient.errors, status: :unprocessable_entity }
        format.js
        format.xml  { render xml: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize! :destroy, @patient
    @patient.destroy

    respond_to do |format|
      format.html { redirect_to(patients_url, notice: 'Patient was successfully destroyed.') }
      format.json  { head :no_content }
      format.xml  { head :no_content }
    end
  end

  private
    def set_patient
      @patient = Patient.find(params[:id])
    end

    def patient_params
      params.require(:patient).permit(:healthnumber, :version_code, :health_expiry_date, :lastname, :firstname, :middlename, :gender, :birthdate, :address1, :address2, :city, :province, :postal_code, :home_phone, :mobile, physician_ids: [])
    end

    def print_token
      uri = URI.parse("#{AppConfig.print_token_url}#{@token.id}/#{@token.patient.healthnumber}")
      #res = Net::HTTP.get_response(uri)
    end

end
