class TestsController < ApplicationController
  before_action :set_test, only: [:show, :edit, :update, :destroy]

  # GET /tests
  # GET /tests.json
  def index
    @tests = Test.all
  end

  # GET /tests/1
  # GET /tests/1.json
  def show
  end

  # GET /tests/new
  def new
    @test = Test.new
    authorize! :new, @test
  end

  # GET /tests/1/edit
  def edit
    authorize! :edit, @test
  end

  # POST /tests
  # POST /tests.json
  def create
    @test = Test.new(test_params)
    authorize! :create, @test

    respond_to do |format|
      if @test.save
        format.html { redirect_to tests_url, notice: 'Test was successfully created.' }
        format.json { render :show, status: :created, location: @test }
      else
        format.html { render :new }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tests/1
  # PATCH/PUT /tests/1.json
  def update
    authorize! :update, @test
    respond_to do |format|
      if @test.update(test_params)
        format.html { redirect_to tests_url, notice: 'Test was successfully updated.' }
        format.json { render :show, status: :ok, location: @test }
      else
        format.html { render :edit }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tests/1
  # DELETE /tests/1.json
  def destroy
    authorize! :destroy, @test
    @test.destroy
    respond_to do |format|
      format.html { redirect_to tests_url, notice: 'Test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test
      @test = Test.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_params
      params.require(:test).permit(:loinc, :test_group_id, :test_code, :test_name, :specimen_source, :group_index, :index, :position, :visible_in_list)
    end
end
