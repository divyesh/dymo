class TestGroupsController < ApplicationController
  before_action :set_test_group, only: [:show, :edit, :update, :destroy]

  # GET /test_groups
  # GET /test_groups.json
  def index
    @test_groups = TestGroup.all.order("position ASC")
  end

  # GET /test_groups/1
  # GET /test_groups/1.json
  def show
  end

  # GET /test_groups/new
  def new
    @test_group = TestGroup.new
    authorize! :new, @test_group
  end

  # GET /test_groups/1/edit
  def edit
    authorize! :edit, @test_group
  end

  # POST /test_groups
  # POST /test_groups.json
  def create
    @test_group = TestGroup.new(test_group_params)
    authorize! :create, @test_group

    respond_to do |format|
      if @test_group.save
        format.html { redirect_to test_groups_url, notice: 'Test group was successfully created.' }
        format.json { render :show, status: :created, location: @test_group }
      else
        format.html { render :new }
        format.json { render json: @test_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /test_groups/1
  # PATCH/PUT /test_groups/1.json
  def update
    authorize! :update, @test_group
    respond_to do |format|
      if @test_group.update(test_group_params)
        format.html { redirect_to test_groups_url, notice: 'Test group was successfully updated.' }
        format.json { render :show, status: :ok, location: @test_group }
      else
        format.html { render :edit }
        format.json { render json: @test_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test_groups/1
  # DELETE /test_groups/1.json
  def destroy
    authorize! :destroy, @test_group
    @test_group.destroy
    respond_to do |format|
      format.html { redirect_to test_groups_url, notice: 'Test group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_group
      @test_group = TestGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_group_params
      params.require(:test_group).permit(:name, :position)
    end
end
