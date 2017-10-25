class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  def valid_info object
    render file: "public/404.html", status: 404, layout: false unless object
  end

  private

  def logged_in_user
    return if logged_in?
    flash[:danger] = t "flash.required_login"
    redirect_to login_url
  end

  def verify_admin
    unless current_user.admin?
      flash[:danger] = t "admin.flash.not_permission"
      redirect_to root_path
    end
  end
end
