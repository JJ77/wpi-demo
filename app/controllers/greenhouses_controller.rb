class GreenhousesController < ApplicationController
  before_action :set_greenhouse, only: [:show, :edit, :update, :destroy]

  # GET /greenhouses
  # GET /greenhouses.json
  def index
    @greenhouses = Greenhouse.all.order(:location_id,:name)
  end

  # GET /greenhouses/1
  # GET /greenhouses/1.json
  def show
    @entries = @greenhouse.current
  end

  # GET /greenhouses/new
  def new
    @greenhouse = Greenhouse.new
  end

  # GET /greenhouses/1/edit
  def edit
  end

  # POST /greenhouses
  # POST /greenhouses.json
  def create
    @greenhouse = Greenhouse.new(greenhouse_params)
    @bed_builder = params["bed_builder"].to_i
    if @greenhouse.save
      unless @bed_builder.nil?
        @bed_builder.times do |bed_number|
          Bed.create(name:bed_number + 1, greenhouse_id:@greenhouse.id)
        end
      end
      redirect_to greenhouses_path, notice: 'Greenhouse was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /greenhouses/1
  # PATCH/PUT /greenhouses/1.json
  def update
    respond_to do |format|
      if @greenhouse.update(greenhouse_params)
        format.html { redirect_to @greenhouse, notice: 'Greenhouse was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @greenhouse.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /greenhouses/1
  # DELETE /greenhouses/1.json
  def destroy
    @greenhouse.destroy
    respond_to do |format|
      format.html { redirect_to greenhouses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_greenhouse
      @greenhouse = Greenhouse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def greenhouse_params
      params.require(:greenhouse).permit(:name, :description, :location_id)
    end
end
