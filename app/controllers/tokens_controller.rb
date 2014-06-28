class TokensController < ApplicationController
  before_action :set_token, only: [:show, :edit, :update, :destroy, :done, :reject, :discard]

  def index
    @tokens = Token.all

    respond_to do |format|
      format.html # index.html.erb
      format.html.phone
      format.json { render :json => @tokens }
      format.xml  { render :xml => @tokens }
    end
  end

  def show
  end

  def new
  end

  def edit
    respond_to do |format|
      format.html # index.html.erb
      format.html.phone
      format.xml  { render :xml => @tokens }
    end
  end

  def create
    options = parse_healthcard(params[:healthcard])

    @patient = Patient.where(healthnumber: options[:healthnumber]).first

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
        token_history.note = @token.current_state.name.to_s
        token_history.save!

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
    else

      # TODO: Create patient, create token and redirec to tokens url

      respond_to do |format|
        format.html { redirect_to tokens_path, notice: 'Patient not Found.' }
        format.json { render text: 'Patient not Found.' }
      end
    end
  end

  def done
    @token.done!
    redirect_to @token, notice: 'Token was successfully updated.'
  end

  def reject
    @token.reject!
    redirect_to @token, notice: 'Token was successfully updated.'
  end

  def discard
    @token.discard!
    redirect_to @token, notice: 'Token was successfully updated.'
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
