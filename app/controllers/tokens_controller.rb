class TokensController < ApplicationController
  before_action :set_token, only: [:show, :edit, :update, :destroy, :done, :reject, :discard]

  def index
    @tokens = Token.where("created_at >= ? OR created_at <= ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day)
  end

  def show
  end

  def new
  end

  def edit
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tokens }
    end
  end

  def create
    options = parse_healthcard(params[:healthcard])

    @patient = Patient.where(healthnumber: options[:healthnumber]).first
    @patient = Patient.create!(options) unless @patient

    @token = Token.where("(created_at >= ? OR created_at <= ?) AND patient_id = ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day, @patient.id).first

    unless @token
      @token = Token.new_time_in_token(@patient)

      # TODO: Make request to print the token

      respond_to do |format|
        format.html { redirect_to tokens_path, notice: 'Token was successfully created.' }
        format.json { render :show, status: :created, location: @token }
      end
    else
      respond_to do |format|
        format.html { redirect_to tokens_path, notice: "Token already generated for this patient for today. Token number is Token#: #{@token.no}." }
        format.json { render :show, status: :created, location: @token }
      end
    end
  end

  def done
    @token.done!
    respond_to do |format|
      format.html { redirect_to @token, notice: "Token was successfully updated." }
      format.json { render :show, status: :created, location: @token }
    end
  end

  def discard
    @token.discard!
    respond_to do |format|
      format.html { redirect_to @token, notice: "Token was successfully updated." }
      format.json { render :show, status: :created, location: @token }
    end
  end

  def update
    respond_to do |format|
      if @token.update(token_params)
        format.html { redirect_to @token, notice: 'Token was successfully updated.' }
        format.json { render :show, status: :ok, location: @token }
      else
        format.html { render :edit }
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
