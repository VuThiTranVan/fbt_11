class BookToursController < ApplicationController
  before_action :logged_in_user
  before_action :load_travel, only: [:new, :create, :edit_prices]

  def index
    @book_tours = current_user.book_tours.order_created_desc
      .paginate page: params[:page], per_page: Settings.book_tour.record_display
    check_nil_return_root_path @book_tours, t("flash.mgs_book_tour_not_found")
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

  def show
    @book_tour = BookTour.find_by id: params[:id]
    if @book_tour.nil?
      flash[:danger] = t "flash.mgs_detail_book_tour_not_found"
      redirect_to user_book_tours_path current_user
    end
  end

  private

  def params_book_tour
    prices = edit_prices
    params.require(:book_tour).permit(:number_person, :note, :tour_id)
      .merge(price: prices[:price], total_price: prices[:total_price])
  end

  def edit_prices
    if @travel.present?
      @prices = {
        price: @travel.price,
        total_price: @travel.price * params[:book_tour][:number_person].to_i
      }
    else
      flash[:danger] = t "flash.msg_book_error_not_found_travel"
      render :new
    end
  end

  def load_travel
    @travel = Travel.find_by id: params[:travel_id]
    check_nil_return_root_path @travel, t("flash.msg_book_error_not_found_travel")
  end

  def check_nil_return_root_path object, message
    if object.nil?
      flash[:danger] = message
      redirect_to root_path
    end
  end
end
