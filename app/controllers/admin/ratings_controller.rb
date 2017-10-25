class Admin::RatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin

  def index
    @ratings = Rating.by_travel(params[:travel_id]).newest.includes(:user)
      .paginate page: params[:page], per_page: Settings.rating.record_display
    unless @ratings.present?
      flash[:danger] = t "admin.flash.ratings.not_found"
      redirect_to travel_path params[:travel_id]
    end
  end
end
