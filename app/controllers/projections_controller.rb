class ProjectionsController < ApplicationController

  def index
  	@entries = Projection.all.includes(:entry)
  end

end
