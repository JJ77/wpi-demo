class ProjectionsController < ApplicationController

  def index
  	if check_projection_queue
  		flash.now[:info] = "You have plants due for grading!  #{view_context.link_to('Click here to roll projections.', projection_queue_entries_path)}".html_safe
  	end
  	@entries = Projection.all.includes(:entry)
  end

  private
    def check_projection_queue
      Projection.ready.empty? ? false : true
    end
end
