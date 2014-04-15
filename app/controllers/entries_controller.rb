class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :set_child_plants, only: [:new, :edit]

  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.order(:stick_week)
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to entries_path, notice: 'Entry was successfully created.' }
        format.json { render action: 'show', status: :created, location: @entry }
      else
        format.html { render action: 'new' }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    @old_entry = Entry.find(params[:id])
    @old_entry.update_attributes(status:1)
    @entry = Entry.new(entry_params)
    if @entry.update(entry_params)
     redirect_to entries_path, notice: 'Entry was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    def set_child_plants
      @child_plant_list = Plant.where.not(parent_plant_id:nil)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:pots, :stick_week, :hang_week, :finish_week, :rating, :status, :plant_id, :bed_id, :greenhouse_id, :location_id)
    end
end
