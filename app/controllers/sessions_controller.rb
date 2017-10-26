class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = t "flash.login_error_mgs"
      render :new
    end
  end

  def destroy
    log_out
    flash[:info] = t "flash.log_out_success"
    redirect_to root_url
  end
end
