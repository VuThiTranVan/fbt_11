module Admin::BookToursHelper
  def load_status
    @statuses ||= BookTour.statuses.map{|key, value| [key.humanize, value]}
  end
end
