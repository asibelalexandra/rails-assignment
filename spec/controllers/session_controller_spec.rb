require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  before do
    @user = User.new(first_name: "Test", last_name: "Test", email: "test@test.com", password: "Test1234!", password_confirmation: "Test1234!")
    @user.save
  end

  subject {
    { session: { email: "test@test.com", password: "Test1234!" } }
  }

  context "POST #create" do
    it "should return a success response" do
      post :create, params: subject
      expect(response).to redirect_to root_path
      expect(flash[:success]).to eq "Successfully logged in."
    end

    it "should not login with invalid credentials" do
      post :create, params: { session: { email: "test@test1.com", password: "Test1234!" } }
      expect(flash[:danger]).to eq "Invalid email/password."
    end
  end

  context "DELETE #destroy" do
    it "should return a success response" do
      delete :destroy, params: { id: @user[:id] }
      expect(response).to redirect_to root_path
      expect(flash[:success]).to eq "Successfully logged out."
    end
  end
end