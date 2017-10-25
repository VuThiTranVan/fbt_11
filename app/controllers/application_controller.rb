class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def valid_info object
    render file: "public/404.html", status: 404, layout: false unless object
  end

  private

  def verify_admin
    unless current_user.admin?
      flash[:danger] = t "admin.flash.not_permission"
      redirect_to root_path
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:name, :address, :telphone, :avatar]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
