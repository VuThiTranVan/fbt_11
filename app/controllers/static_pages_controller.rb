class StaticPagesController < ApplicationController
  def show
    @travels = Travel.all_travels.includes(:images, :ratings)
      .paginate page: params[:page], per_page: Settings.travel.record_display

    if valid_page?
      render template: "static_pages/#{params[:url_page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private

  # check url
  def valid_page?
    File.exist? Pathname.new(Rails.root +
      "app/views/static_pages/#{params[:url_page]}.html.erb")
  end
end
