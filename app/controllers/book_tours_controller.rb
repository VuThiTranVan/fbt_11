class BookToursController < ApplicationController
  before_action :authenticate_user!
  before_action :load_travel, only: [:new, :create]
  before_action :load_book_tour, only: [:show, :update]
  before_action :tour_valid, only: [:new, :create]

  def index
    @book_tours = current_user.book_tours.includes(:tour).newest
      .paginate page: params[:page], per_page: Settings.book_tour.record_display
    if @book_tours.blank?
      flash[:danger] =  t "flash.mgs_book_tour_not_found"
      redirect_to root_path
    end
  end

  def new
    @book_tour = BookTour.new
  end

  def create
    @book_tour = current_user.book_tours.build params_book_tour
    if @book_tour.save
      flash[:info] = t "flash.mgs_success_book_tour"
      redirect_to travel_book_tour_path @travel, @book_tour
    else
      flash[:danger] = t "flash.mgs_fail_book_tour"
      redirect_to travel_path @travel
    end
  end

  def show; end

  def update
    if @book_tour.update_attributes params_book_tour_cancel
      flash[:info] = t "flash.cancel_book_tour_success"
    else
      flash[:danger] = t "flash.cancel_book_tour_error"
    end
    redirect_to user_book_tours_path current_user
  end

  private

  def params_book_tour
    params.require(:book_tour)
      .permit :number_person, :note, :tour_id, :price, :total_price
  end

  def load_travel
    @travel = Travel.find_by id: params[:travel_id]
    if @travel.nil?
      flash[:danger] = t "flash.msg_book_error_not_found_travel"
      redirect_to root_path
    end
  end

  def load_book_tour
    @book_tour = BookTour.includes(:tour).find_by id: params[:id]
    if @book_tour.nil?
      flash[:danger] = t "flash.mgs_detail_book_tour_not_found"
      redirect_to user_book_tours_path current_user
    end
  end

  def params_book_tour_cancel
    params.require(:book_tour).permit(:status)
      .merge status: BookTour.statuses[:cancel]
  end

  def tour_valid
    unless @travel.tours.start_date_greater_today.present?
      flash[:info] = t "flash.msg_tour_not_found_to_book"
      redirect_to travel_path @travel
    end
  end
end
