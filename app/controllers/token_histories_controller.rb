class TokenHistoriesController < ApplicationController
  before_action :set_token_history, only: [:show, :edit, :update, :destroy]
  before_action :set_token

  # GET /token_histories
  # GET /token_histories.json
  def index
    @token_histories = TokenHistory.all
  end

  # GET /token_histories/1
  # GET /token_histories/1.json
  def show
  end

  # GET /token_histories/new
  def new
    @token_history = @token.token_histories.new
  end

  # GET /token_histories/1/edit
  def edit
  end

  # POST /token_histories
  # POST /token_histories.json
  def create
    @token_history = @token.token_histories.new(token_history_params)

    respond_to do |format|
      if @token_history.save
        format.html { redirect_to @token, notice: 'Token punched successfully created.' }
        format.json { render :show, status: :created, location: @token_history }
      else
        format.html { render :new }
        format.json { render json: @token_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /token_histories/1
  # PATCH/PUT /token_histories/1.json
  def update
    respond_to do |format|
      if @token_history.update(token_history_params)
        format.html { redirect_to @token, notice: 'Token history was successfully updated.' }
        format.json { render :show, status: :ok, location: @token_history }
      else
        format.html { render :edit }
        format.json { render json: @token_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /token_histories/1
  # DELETE /token_histories/1.json
  def destroy
    @token_history.destroy
    respond_to do |format|
      format.html { redirect_to @token, notice: 'Token history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_token
      @token = Token.find(params[:token_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_token_history
      @token_history = TokenHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def token_history_params
      params.require(:token_history).permit(:token_id, :punch_in_time, :note)
    end
end
