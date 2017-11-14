require "rails_helper"
 RSpec.describe Place, type: :model do
  let(:place_from){FactoryGirl.create :place}
  let(:place_to){FactoryGirl.create :place}
  let(:travel_place) do
    FactoryGirl.create :travel, id_place_from: place_from.id, id_place_to: place_to.id
  end

  context "association" do
    it "should correctly identify the has_many relationship" do
      expect(place_from.id).to be_eql travel_place.place_from.id
      expect(place_to.id).to be_eql travel_place.place_to.id
    end
  end

  context "relationship" do
    it {expect(place_from.id).to be_eql travel_place.place_from.id}
    it {expect(place_to.id).to be_eql travel_place.place_to.id}
  end

  context "valid when city not nil" do
    it {is_expected.to validate_presence_of :city}
  end

  context "scope city DESC" do
    let!(:place_one){Place.create city: "The Count of Monte Cristo"}
    let!(:place_two){Place.create city: "Animal Farm"}
    it "orders by ascending city" do
      Place.all.except eq [place_two, place_one]
    end
  end
end
