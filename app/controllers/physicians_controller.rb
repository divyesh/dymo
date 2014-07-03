class PhysiciansController < ApplicationController
  before_action :set_physician, only: [:show, :edit, :update, :destroy]

  def index
    @physicians = Physician.search(params[:term]).order("lastname").paginate(per_page: 20, page: params[:page])
  end

  def show
  end

  def new
    @physician = Physician.new
  end

  def edit
  end

  def create
    @physician = Physician.new(physician_params)

    respond_to do |format|
      if @physician.save
        format.html { redirect_to(@physician, notice: 'Physician was successfully created.') }
        format.json  { render json: @physician, status: :created, location: @physician }
        format.xml  { render xml: @physician, status: :created, location: @physician }
      else
        format.html { render action: "new" }
        format.json  { render json: @physician.errors, status: :unprocessable_entity }
        format.xml  { render xml: @physician.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @physician = Physician.find(params[:id])

    respond_to do |format|
      if @physician.update_attributes(physician_params)
        format.html { redirect_to(@physician, notice: 'Physician was successfully updated.') }
        format.json  { head :no_content }
        format.xml  { head :no_content }
      else
        format.html { render action: "edit" }
        format.json  { render json: @physician.errors, status: :unprocessable_entity }
        format.xml  { render xml: @physician.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @physician.destroy

    respond_to do |format|
      format.html { redirect_to(physicians_url) }
      format.json  { head :no_content }
      format.xml  { head :no_content }
    end
  end

  private
    def set_physician
      @physician = Physician.find(params[:id])
    end

    def physician_params
      params.require(:physician).permit(:physician_number, :lastname, :firstname, :middlename, :cpso, :gender, :location, :address1, :address2, :city, :province, :postal_code, :phone, :fax, :emergency_number, :email)
    end

end
