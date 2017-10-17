class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def helloword
    render html: I18n.t(".hello")
  end
end
