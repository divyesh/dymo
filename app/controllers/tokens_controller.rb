class TokensController < ApplicationController
  before_action :set_token, only: [:show, :edit, :update, :destroy]

  def index
    @tokens = Token.all

    respond_to do |format|
      format.html # index.html.erb
      format.html.phone      
      format.xml  { render :xml => @tokens }
    end
  end

  def show
    respond_to do |format|
      format.html # index.html.erb
      format.html.phone      
      format.xml  { render :xml => @tokens }
    end
  end

  def new
    @patient = Patient.where(healthnumber: params[:healthnumber]).first

    if @patient
      @token = Token.where("date(created_at) = ? AND patient_id = ?", Date.today, @patient.id).first

      unless @token
        @token = Token.new({
          patient: @patient,
          no: Token.where("date(created_at) = ?", Date.today).size + 1
        })

        @token.save!

        token_history = @token.token_histories.build
        token_history.punch_in_time = @token.created_at
        token_history.note = "Time in"
        token_history.save!

        redirect_to tokens_path, notice: "Token generated successfully."
      else
        redirect_to tokens_path, notice: "Token already generated for this patient for today. Token number is #{@token.no}."
      end
    else
      redirect_to tokens_path, notice: "Patient not found."
    end
  end

  def edit
    respond_to do |format|
      format.html # index.html.erb
      format.html.phone      
      format.xml  { render :xml => @tokens }
    end
  end

  def create
    @token = Token.new(token_params)

    respond_to do |format|
      if @token.save
        format.html { redirect_to @token, notice: 'Token was successfully created.' }
        format.json { render :show, status: :created, location: @token }
      else
        format.html { render :new }
        format.html.phone { render :new }
        format.json { render json: @token.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @token.update(token_params)
        format.html { redirect_to @token, notice: 'Token was successfully updated.' }
        format.json { render :show, status: :ok, location: @token }
      else
        format.html { render :edit }
        format.html.phone { render :edit }
        format.json { render json: @token.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @token.destroy
    respond_to do |format|
      format.html { redirect_to tokens_url, notice: 'Token was successfully destroyed.' } 
      format.json { head :no_content }
    end
  end

  private
    def set_token
      @token = Token.find(params[:id])
    end

    def token_params
      params.require(:token).permit(:no, :patient_id)
    end
end
