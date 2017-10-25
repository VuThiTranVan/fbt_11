class TravelsController < ApplicationController
  def show
    @travel = Travel.find_by id: params[:id]
    if @travel.nil?
      flash[:danger] = "not found"
      redirect_to root_path
    else
      @images = @travel.images
      @comments = @travel.comments
      @tours = @travel.tours
    end
  end
end
