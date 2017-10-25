class RatingsController < ApplicationController
  before_action :authenticate_user!, only: [:action_ratings]

  def action_rating
    @rating =
      Rating.find_by travel_id: params[:travel_id], user_id: current_user.id

    if @rating.present?
      update_rating @rating
    else
      create_rating
    end
  end

  private

  def create_rating
    rating =
      current_user.ratings.build(
        star_number: params[:star_number], travel_id: params[:travel_id])
    if rating.save
      respond_success
    else
      respond_error
    end
  end

  def update_rating rating
    if rating.update_attributes star_number: params[:star_number]
      respond_success
    else
      respond_error
    end
  end

  def respond_error
    respond_to do |format|
      format.json{render json: {message: t("flash.rating_create_error")},
        status: :unprocessable_entity}
      format.html{}
    end
  end

  def respond_success
    @star_number = Travel.find_by(id: params[:travel_id]).average_rating

    respond_to do |format|
      format.json{render json: {star_number: @star_number}}
      format.html{}
    end
  end
end
