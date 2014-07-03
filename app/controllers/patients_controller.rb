class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  def index
    @patients = Patient.search(params[:search]).order("created_at desc").paginate(per_page: 5, page: params[:page])
  end

  def show
  end

  def new
    @patient = Patient.new
  end

  def edit
  end

  def create
    @patient = Patient.new(patient_params)

    respond_to do |format|
      if @patient.save
        Visit.create({ physician_id: params[:physician_id1], patient_id: @patient.id, visitdate: params[:visitdate] })

        format.html { redirect_to(@patient, notice: 'Patient was successfully created.') }
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

    respond_to do |format|
      if @patient.update_attributes(patient_params)
        visit = Visit.new({ physician_id: params[:physician_id1], patient_id: @patient.id, visitdate: params[:visitdate] })
        if visit.save
          token = @patient.time_in_token
          token.add_visit! if token
        end

        format.html { redirect_to(@patient, notice => 'Patient was successfully updated.') }
        format.json  { head :no_content }
        format.xml  { head :no_content }
      else
        format.html { render action: "edit" }
        format.json  { render json: @patient.errors, status: :unprocessable_entity }
        format.xml  { render xml: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @patient.destroy

    respond_to do |format|
      format.html { redirect_to(patients_url) }
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

end
