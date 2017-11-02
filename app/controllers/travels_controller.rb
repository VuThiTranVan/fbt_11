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
      @ratings = @travel.ratings
    end
  end

  def search
    @travels = Travel.includes(:images, :ratings)
      .by_place_from(params[:place_form])
      .by_place_to(params[:place_to])
      .by_date_of_tours(params[:date_of_departure])
    @travels = if params[:price].present? && params[:price] == Settings.search_price.over_6
      @travels.by_price_max_range(params[:price])
    elsif params[:price].present?
      @travels.by_price_between_range(params[:price].split(".."))
    else
      @travels
    end.paginate page: params[:page], per_page: Settings.travel.record_display

    respond_to do |format|
      format.html{render @travels}
      format.json{head :no_content}
      format.js{render layout: false}
    end
  end
end
