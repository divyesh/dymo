class VisitsController < ApplicationController

  # GET /visits
  # GET /visits.xml
  def index
    @visits = Visit.search(params[:search]).order("created_at desc").paginate(:per_page => 25, :page => params[:page])

    respond_to do |format|
      format.html
      format.html.phone
      format.xml  { render :xml => @visits }
    end
  end

  # GET /visits/1
  # GET /visits/1.xml
  def show
    redirect_to(visits_url)
    return

    @visit = Visit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @visit }
    end
  end

  # GET /visits/new
  # GET /visits/new.xml
  def new
    @visit = Visit.new
    @visit.patient_id = params[:patient_id] unless params[:patient_id].nil?

    respond_to do |format|
      format.html # new.html.erb
      format.html.phone
      format.xml  { render :xml => @visit }
    end
  end

  # GET /visits/1/edit
  def edit
    redirect_to(visits_url)
    return

    @visit = Visit.find(params[:id])
  end

  # POST /visits
  # POST /visits.xml
  def create
    @visit = Visit.new(visit_params)

    respond_to do |format|
      if @visit.save
        token = @visit.patient.time_in_token
        token.add_visit! if token

        format.html { redirect_to(@visit, :notice => 'Visit was successfully created and token time registered.') }
        format.xml  { render :xml => @visit, :status => :created, :location => @visit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @visit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /visits/1
  # PUT /visits/1.xml
  def update
    @visit = Visit.find(params[:id])

    respond_to do |format|
      if @visit.update_attributes(visit_params)
        format.html { redirect_to(@visit, :notice => 'Visit was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @visit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /visits/1
  # DELETE /visits/1.xml
  def destroy
    @visit = Visit.find(params[:id])
    @visit.destroy

    respond_to do |format|
      format.html { redirect_to(visits_url) }
      format.xml  { head :ok }
    end
  end

  private

  def visit_params
    params.require(:visit).permit(:patient_id, :physician_id)
  end

end
