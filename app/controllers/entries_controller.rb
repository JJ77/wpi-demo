class EntriesController < ApplicationController
  helper:entries
  before_action :set_entry, only: [:wipe, :show, :edit, :update, :destroy]
  before_action :set_child_plants, only: [:new, :edit]
  # GET /entries
  def index
    if check_projection_queue
      flash.now[:alert] = "You have plants due for grading!  #{view_context.link_to('Click here to roll projections.', projection_queue_entries_path)}".html_safe
    end
    @entries = Entry.where(status:0).includes(:plant, :bed).order(:stick_week)
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
    if check_bed && @entry.save
      params[:projections].each do |key, value|
        create_projection(key, value, @entry)
      end
    redirect_to entries_path, notice: 'Entry was successfully created.'
    else
      set_child_plants
      render action: 'new'
    end
  end

  # PATCH/PUT /entries/1
  def update
    @old_entry = Entry.find(params[:id])
    @entry = Entry.new(entry_params)
    unless @old_entry == @entry
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

  def projection_queue
    @projections = Projection.ready
  end

  def projection_conversion
    @projections = Projection.ready
    @projections.each do |entry|
      if params["entry_ids"] && params["entry_ids"].has_key?(entry.id.to_s)
        @entry = Entry.new(
            stick_week:entry.stick_week,
            plant_id:entry.plant_id,
            finish_week:entry.finish_week,
            rating: 4,
            bed_id:params["entry_bed"][entry.id.to_s],
            greenhouse_id:params["entry_greenhouses"][entry.id.to_s],
            location_id:params["entry_locations"][entry.id.to_s],
            pots:params["entry_pots"][entry.id.to_s],
            status: 0)
        @entry.save
        entry.destroy
      else
        entry.update_attributes(delay_week:current_week + 1)
      end
    end
    redirect_to entries_path
  end


  private

    def check_projection_queue
      Projection.ready.empty? ? false : true
    end

    def check_bed
      entry = Entry.where(bed_id:params["entry"]["bed_id"], status:0, plant_id:params["entry"]["plant_id"], stick_week:params["entry"]["stick_week"])
      if entry.empty?
        true
      else
        flash.now[:error] = "That bed already has an entry of that plant on the same week!  #{view_context.link_to('Click here to modify it.', edit_entry_path(entry.first.id))}".html_safe
        false
      end
    end

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
