class EntriesController < ApplicationController
  before_action :set_entry, only: [:wipe, :show, :edit, :update, :destroy]
  before_action :set_child_plants, only: [:new, :edit]

  # GET /entries
  def index
    # Temp code for debugging purposes
    #@entries = Entry.order(:stick_week)
    #Production code!
    @entries = Entry.where(status:0).order(:stick_week)
  end

  # GET /entries/1
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
  def create
    @entry = Entry.new(entry_params)

    respond_to do |format|
      if @entry.save
        params[:projections].each do |key, value|
          create_projection(key, value, @entry)
        end
        format.html { redirect_to entries_path, notice: 'Entry was successfully created.' }
        format.json { render action: 'show', status: :created, location: @entry }
      else
        format.html { render action: 'new' }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  def update
    @old_entry = Entry.find(params[:id])
    @entry = Entry.new(entry_params)
    unless @old_entry.compare(@entry)
      @old_entry.update_attributes(status:1)
      @entry.save
      params[:projections].each do |key, value|
        update_projection(key, value, @entry)
      end
      redirect_to entries_path, notice: 'Entry was successfully updated.'
    else
      redirect_to entries_path
      flash.alert = 'No changes were found for entry.'
    end
  end

  # DELETE /entries/1
  def destroy
    @entry.update_attributes(status:1)
    redirect_to entries_url
  end

  def wipe
    @entry.destroy
    redirect_to entries_url
  end

  private

    # Pulls up a projection and updates its pot count
    def update_projection(plant_id, pots, parent)
      unless pots == ""
        @projection = Projection.find(plant_id)
        @projection.update_attributes(pots:pots)
      end
    end

    # Creates a new projection
    def create_projection(plant_id, pots, parent)
      unless pots == ""
        Projection.create(plant_id:plant_id,
                          pots:pots,
                          finish_week: parent.finish_week,
                          entry_id:parent.id)
      end
    end

    def set_entry
      @entry = Entry.find(params[:id])
    end

    def set_child_plants
      @child_plant_list = Plant.where.not(parent_plant_id:nil)
    end

    def entry_params
      params.require(:entry).permit(:pots, :stick_week, :hang_week, :finish_week, :rating, :status, :plant_id, :bed_id, :greenhouse_id, :location_id)
    end
end
