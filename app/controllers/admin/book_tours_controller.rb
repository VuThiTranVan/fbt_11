class Admin::BookToursController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :load_book_tour, only: [:show, :update]

  def index
    @book_tours = BookTour.by_order_status_and_created_at.includes(:tour, :user)
      .paginate page: params[:page], per_page: Settings.book_tour.record_display
    if params[:status_eq].present?
      @book_tours = @book_tours.status_eq(params[:status_eq])
    end
    if params[:created_at_lteq].present?
      @book_tours = @book_tours.created_at_lteq(params[:created_at_lteq])
    end
    if params[:created_at_gteq].present?
      @book_tours = @book_tours.created_at_gteq(params[:created_at_gteq])
    end
    respond_to do |format|
      format.html
      format.json{head :no_content}
      format.js{render layout: false}
    end
  end

  def show; end

  def update
    if @book_tour.update_attributes id: params[:id], status: params[:status].to_i
      respond_to do |format|
        format.json{render @book_tour}
        format.json{head :no_content}
        format.js{render layout: false}
      end
    else
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  private

  def load_book_tour
    @book_tour = BookTour.includes(:tour, :user).find_by id: params[:id]
    if @book_tour.nil?
      flash[:danger] = t "admin.flash.book_tours_not_found"
      redirect_to admin_book_tours_path
    end
  end
end
