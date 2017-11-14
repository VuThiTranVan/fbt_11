require "rails_helper"

RSpec.describe "static_pages/home.html.erb", type: :view do
  let(:place1){FactoryBot.create :place}
  let(:place2){FactoryBot.create :place}
  let(:travel) do
    FactoryBot.create(
      :travel,
      id_place_from: place1.id,
      id_place_to: place2.id)
  end
  let!(:image){FactoryBot.create :image, travel_id: travel.id}

  subject{travel}

  before do
    allow(view).to receive_messages(will_paginate: nil) # Add this
    assign :travels, travel

    render
  end

  context "should form search" do
    it "display item Place Departure" do
      expect(rendered).to include '<select name="place_form" id="place_form" class="form-control"><option value="">Place Departure</option>'
    end
    it "display item Destination" do
      expect(rendered).to include '<select name="place_to" id="place_to" class="form-control"><option value="">Destination</option>'
    end
    it "display button Price" do
      expect(rendered).to include '<select name="price" id="price" class="form-control"><option value="">Price</option>'
    end
    it "display item Date of departure" do
      expect(rendered).to include '<input type="date" name="date_of_departure" id="date_of_departure" class="form-control datepicker" />'
    end
    it "display button search" do
      expect(rendered).to include '<input type="submit" name="commit" value="Search" class="btn btn-primary margin_top_20" data-disable-with="Search" />'
    end
    it "should get search path in form search" do
      expect(rendered).to include search_path
    end
  end

  context "should index travels" do
    it "display header travels" do
      expect(rendered).to include '<h3>Travels</h3>'
    end
    # Test view data of item travel
    before do
      render "travels/travel.html.erb", travel: travel
    end
    it {expect(rendered).to include travel.images.first.picture.url}
    it {expect(rendered).to include travel.name}
    it {expect(rendered).to include travel.tour_duration}
    it {expect(rendered).to include '<input type="hidden" class="rating rating_js'}
  end

  context "should redirect travel detail" do
    before do
      render "travels/travel.html.erb", travel: travel
    end
    it {expect(rendered).to include travel_path travel}
  end
end
