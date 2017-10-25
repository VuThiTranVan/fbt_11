module FormSearchTravelHelper
  def places_for_select_box
    @places = Place.order_city_desc.pluck :city, :id
  end
end
