class PhysiciansController < ApplicationController
  # GET /physicians
  # GET /physicians.xml
  def index
    @physicians = Physician.search(params[:search]).order("created_at desc").paginate(:per_page => 5, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.html.phone
      format.xml  { render :xml => @physicians }
    end
  end

  # GET /physicians/1
  # GET /physicians/1.xml
  def show
    @physician = Physician.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.html.phone
      format.xml  { render :xml => @physician }
    end
  end

  # GET /physicians/new
  # GET /physicians/new.xml
  def new
    @physician = Physician.new

    respond_to do |format|
      format.html # new.html.erb
      format.html.phone
      format.xml  { render :xml => @physician }
    end
  end

  # GET /physicians/1/edit
  def edit
    @physician = Physician.find(params[:id])
    respond_to do |format|
      format.html # new.html.erb
      format.html.phone
    end
  end

  # POST /physicians
  # POST /physicians.xml
  def create
    @physician = Physician.new(physician_params)

    respond_to do |format|
      if @physician.save
        format.html { redirect_to(@physician, :notice => 'Physician was successfully created.') }
        format.xml  { render :xml => @physician, :status => :created, :location => @physician }
      else
        format.html { render :action => "new" }
        format.html.phone { render :action => "new" }
        format.xml  { render :xml => @physician.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /physicians/1
  # PUT /physicians/1.xml
  def update
    @physician = Physician.find(params[:id])

    respond_to do |format|
      if @physician.update_attributes(physician_params)
        format.html { redirect_to(@physician, :notice => 'Physician was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.html.phone { render :action => "edit" }
        format.xml  { render :xml => @physician.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /physicians/1
  # DELETE /physicians/1.xml
  def destroy
    @physician = Physician.find(params[:id])
    @physician.destroy

    respond_to do |format|
      format.html { redirect_to(physicians_url) }
      format.xml  { head :ok }
    end
  end

  private

  def physician_params
    params.require(:physician).permit(:physician_number, :lastname, :firstname, :middlename, :cpso, :gender, :location, :address1, :address2, :city, :province, :postal_code, :phone, :fax, :emergency_number, :email)
  end

end
