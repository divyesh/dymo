require 'net/http'

class TokensController < ApplicationController
  before_action :set_token, only: [:show, :edit, :update, :destroy, :done, :reject, :discard]

  def index
    @patient = Patient.new
    date = filter_date(:start_date)

    if !params[:state].nil? && params[:state] != 'all'
      @tokens = Token.where("(created_at >= ? AND created_at <= ?) AND state = ?", date.beginning_of_day, date.end_of_day, params[:state])
    else
      @tokens = Token.where("(created_at >= ? AND created_at <= ?)", date.beginning_of_day, date.end_of_day)
    end
    render text: '' if request.xhr? && @tokens.empty?
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
    @patient = Patient.create(options) unless @patient

    unless @patient.errors.any?
      @token = Token.where("(created_at >= ? AND created_at <= ?) AND patient_id = ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day, @patient.id).first

      if @token.nil? || @token.generatable?
        @token = Token.new_time_in_token(@patient)

        print_token

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
    else
      respond_to do |format|
        format.html { redirect_to tokens_path, notice: "Patient does not exist. Add patient using 'Add Patient' link on this page -->" }
        format.json { render text: 'Patient does not exist.' }
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

    def print_token
      uri = URI.parse("#{AppConfig.print_token_url}#{@token.id}/#{@token.patient.healthnumber}")
      # res = Net::HTTP.get_response(uri)
    end
end
