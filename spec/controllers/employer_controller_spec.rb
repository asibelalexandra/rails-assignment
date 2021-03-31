require 'rails_helper'

RSpec.describe EmployerController, type: :controller do

  subject {
    { employer_name: "test_employer" }
  }

  context "GET #index" do
    it "should return a success response" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  context "GET #new" do
    it "should return a success response" do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  context "PUT #create" do
    it "should return a success response" do
      post :create, params: subject
      expect(response).to redirect_to employer_index_path
    end
  end

  context "GET #show" do
    it "should return a success response" do
      post :create, params: subject
      employer = Employer.last

      get :show, params: { id: employer[:id] }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end
end
