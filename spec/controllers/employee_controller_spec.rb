require 'rails_helper'

RSpec.describe EmployeeController, type: :controller do

  before do
    @employer = Employer.new(employer_name: "Test")
    @employer.save
  end

  subject {
    { first_name: "test", last_name: "test", employer_id: @employer[:id] }
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
      expect(response).to redirect_to employee_index_path
    end
  end

  context "GET #show" do
    it "should return a success response" do
      post :create, params: subject
      employee = Employee.last

      get :show, params: { id: employee[:id] }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end
end
