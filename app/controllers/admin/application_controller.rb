class Admin::ApplicationController < ActionController::Base
  layout "admin/application"
  protect_from_forgery with: :exception
end
