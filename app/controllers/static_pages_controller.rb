class StaticPagesController < ApplicationController
  def index
    @travels = Travel.order_created_desc.includes(:images, :ratings)
      .paginate page: params[:page], per_page: Settings.travel.record_display
  end
end
