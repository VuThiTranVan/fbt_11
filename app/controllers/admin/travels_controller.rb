class Admin::TravelsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin
  before_action :load_travel

  def edit; end

  def update
    if @travel.update_attributes params_travel
      flash[:info] = t "admin.flash.travels.edit.mgs_success"
      redirect_to travel_path @travel
    else
      flash[:danger] = t "admin.flash.travels.edit.mgs_error"
      render :edit
    end
  end

  private

  def params_travel
    params.require(:travel)
      .permit :name, :price, :id_place_from, :id_place_to, :schedule, :desciption, :note
  end

  def load_travel
    @travel = Travel.find_by id: params[:id]
    if @travel.nil?
      flash[:danger] = t "admin.flash.travels.not_found"
      redirect_to root_path
    end
  end
end
