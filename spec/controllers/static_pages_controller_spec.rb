require "rails_helper"

RSpec.describe StaticPagesController, type: :controller do
  let(:place1){FactoryBot.create :place}
  let(:place2){FactoryBot.create :place}
  let(:travel) do
    FactoryBot.create(
      :travel,
      id_place_from: place1.id,
      id_place_to: place2.id)
  end

  context "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template :index
      expect(response).to have_http_status(200)
    end
    it "assigns @travels" do
      get :index
      expect(assigns(:travels)).to include travel
    end
    it "get root_path" do
      expect(get: root_path).to route_to "static_pages#index"
    end
    it "get status" do
      get :index
      expect(response).to have_http_status(200)
    end
  end
end
