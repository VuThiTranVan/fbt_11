class UsersController < ApplicationController
  before_action :load_user, except: [:new, :create]

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:info] = t "flash.create_user_success"
      redirect_to root_path
    else
      flash[:danger] = t "flash.create_user_fail" if user_params.present?
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :address,
      :telphone,
      :avatar
    )
  end

  def load_user
    @user = User.find_by id: params[:id]
    valid_info @user
  end
end
