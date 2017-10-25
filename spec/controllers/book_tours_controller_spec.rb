require "rails_helper"

RSpec.describe BookToursController, type: :controller do
  let(:place1){FactoryBot.create :place}
  let(:place2){FactoryBot.create :place}
  let(:travel) do
    FactoryBot.create(
      :travel,
      id_place_from: place1.id,
      id_place_to: place2.id)
  end

  let!(:tour){FactoryBot.create :tour, travel_id: travel.id}

  subject {travel}

  describe "GET #index" do
    before(:each) do
      # before_action :authenticate_user!
      @user = FactoryBot.create :user
      sign_in @user
      @book_tour = FactoryBot.create :book_tour, tour_id: tour.id, user_id: @user.id
    end

    it "should render index page"  do
      get :index, params: {user_id: @user.id}
      expect(response).to be_success
      expect(response).to have_http_status 200
      expect(subject).to render_template :index
    end
  end

  describe "GET #show" do
    before :each do
      @user = FactoryBot.create :user
      sign_in @user
      @book_tour = FactoryBot.create :book_tour, tour_id: tour.id, user_id: @user.id
    end

    it "should render index page"  do
      get :show, params: {travel_id: travel.id, id: @book_tour}
      expect(response).to be_success
      expect(response).to have_http_status 200
      expect(assigns(:book_tour)).to eq @book_tour
      expect(subject).to render_template :show
    end
  end

  describe "GET #new" do
    before :each do
      @user = FactoryBot.create :user
      sign_in @user
    end

    it "should render new page" do
      get :new, params: {travel_id: travel.id}
      expect(response).to be_success
      expect(response).to have_http_status 200
      expect(subject).to render_template :new
    end

    it "when loggin yet return root_path" do
      sign_out  @user
      get :new, params: {travel_id: travel.id}
      expect(response).to redirect_to new_user_session_path
    end

    it "when travel invalid return root_path and flash danger" do
      sign_in @user
      get :new, params: {travel_id: 1321}
      expect(flash[:danger]).to eq "Travel is not found"
      expect(response).to redirect_to root_path
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        @user = FactoryBot.create :user
        sign_in @user
      end

      it "created book tour" do
        book_tour = {
          number_person: Faker::Number.number(1),
          note: Faker::Lorem.sentence(5),
          price: Faker::Number.between(100, 1100),
          total_price: Faker::Number.between(100, 1100),
          tour_id: tour.id}
        post :create, params: {travel_id: travel.id, book_tour: book_tour}
        expect(flash[:info]).to eq "You have successfully completed the booking of tours. Please wait amoment to admin accept"
        expect(response).to redirect_to travel_book_tour_path id: BookTour.last
      end
    end

    context "with invalid attributes" do
      before do
        @user = FactoryBot.create :user
        sign_in @user
      end

      it "don't create book tour" do
        post :create, params: {travel_id: travel.id, book_tour: {number_person: nil}}
        expect(flash[:danger]).to eq "Booking tour fail"
        expect(response).to redirect_to travel_path travel
      end
    end
  end

  describe 'PUT update' do
    before :each do
      @user = FactoryBot.create :user
      sign_in @user
      @book_tour = FactoryBot.create :book_tour, tour_id: tour.id, user_id: @user.id
    end

    context "valid attributes" do
      it "changes @book_tour's attributes" do
        book_tour = {id: @book_tour.id}
        put :update, params: {user_id: @user.id, id: @book_tour.id, book_tour: book_tour}
        @book_tour.reload
        expect(@book_tour.status).to eq "cancel"
      end

      it "redirects to the book tour index" do
        book_tour = {id: @book_tour.id}
        put :update, params: {user_id: @user.id, id: @book_tour.id, book_tour: book_tour}
        expect(flash[:info]).to eq "Cancel book tour successfully."
        expect(response).to redirect_to user_book_tours_path @user
      end
    end

    context "invalid attributes" do
      it "does not change book_tour's attributes" do
        put :update, params: {user_id: @user.id, id: @book_tour.id, book_tour: {id: 123}}
        @book_tour.reload
        expect(@book_tour.status).to eq "cancel"
      end

      it "redirects to the book tour index" do
        put :update, params: {user_id: @user.id, id: @book_tour.id, book_tour: {id: 123}}
        expect(response).to redirect_to user_book_tours_path @user
      end
    end
  end
end
