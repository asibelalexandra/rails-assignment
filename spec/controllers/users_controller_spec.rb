require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  subject {
    { first_name: "Test", last_name: "Test", email: "test@test.com", password: "Test1234!", password_confirmation: "Test1234!" }
  }

  context "GET #new" do
    it "should return a success response" do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  context "POST #create" do
    it "should return a success response" do
      post :create, params: { user: subject }
      expect(response).to redirect_to root_path
      expect(flash[:success]).to eq "Successfully logged in."
    end
  end
  #
  # test "user registration, logout and login" do
  #   post users_path, params: { user: { first_name: "Test", last_name: "Test", email: "test@test.com", password: "Test1234!", password_confirmation: "Test1234!"} }
  #
  #   delete "/logout"
  #   assert_response :redirect
  #   assert_equal "Successfully logged out.", flash[:success]
  #
  #   post "/login", params: { session: { email: "test@test.com", password: "Test1234!" } }
  #   assert_response :redirect
  #   assert_equal "Successfully logged in.", flash[:success]
  # end
end
