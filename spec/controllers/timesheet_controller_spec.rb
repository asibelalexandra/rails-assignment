require 'rails_helper'

RSpec.describe TimesheetController, type: :controller do

  before do
    @employer = Employer.new(employer_name: "Test")
    @employer.save

    @employee = Employee.new(first_name: "Test", last_name: "Test", employer_id: Employer.last[:id])
    @employee.save

    @budget = Budget.new(budget_name: "Test", hours: 30, start_date: "2021-01-01", end_date: "2021-01-30", employer_id: Employer.last[:id])
    @budget.save
  end

  subject {
    { employee_id: @employee[:id], budget_id: @budget[:id], hours: 1, date_of_service: "2021-01-02" }
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

  context "POST #create" do
    it "should return a success response" do
      post :create, params: subject
      timesheet = Timesheet.last

      expect(response).to redirect_to timesheet_index_path
      expect(flash[:success]).to eq format('Successfully added timesheet with id %s.', timesheet[:id])
    end
  end

  context "GET #show" do
    it "should return a success response" do
      post :create, params: subject
      timesheet = Timesheet.last

      get :show, params: { id: timesheet[:id] }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end

  context "GET #edit" do
    it "should return a success response" do
      post :create, params: subject
      timesheet = Timesheet.last

      get :edit, params: { id: timesheet[:id] }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
    end
  end

  context "PUT #update" do
    it "should return a success response" do
      post :create, params: subject
      timesheet = Timesheet.last

      put :update, params: { id: timesheet[:id], timesheet: subject }
      expect(response).to redirect_to timesheet_index_path
      expect(flash[:success]).to eq format('Successfully saved timesheet with id %s.', timesheet[:id])
    end
  end

  it "remove timesheet correctly" do
    post :create, params: subject
    timesheet = Timesheet.last

    delete :destroy, params: { id: timesheet[:id] }
    expect(response).to redirect_to root_path
    expect(flash[:success]).to eq format('Successfully deleted timesheet with id %s.', timesheet[:id])
  end

  it "verifies if new timesheet is by default not approved " do
    post :create, params: subject
    timesheet = Timesheet.last

    expect(timesheet.approved).to eq false
  end    
 
  it "verifies if existing timesheet can be approved" do
    post :create, params: subject
    timesheet = Timesheet.last

    post :approve, params: { timesheet_id: timesheet[:id] }
    expect(response).to redirect_to root_path
    expect(flash[:success]).to eq format('Successfully approved timesheet with id %s.', timesheet[:id])
    
    timesheet = Timesheet.last
    expect(timesheet.approved).to eq true
  end    

  it "verifies if existing and approved timesheet can be unapproved" do
    post :create, params: subject
    timesheet = Timesheet.last

    post :approve, params: { timesheet_id: timesheet[:id] }
    post :unapprove, params: { timesheet_id: timesheet[:id] }

    expect(response).to redirect_to root_path
    expect(flash[:success]).to eq format('Successfully unapproved timesheet with id %s.', timesheet[:id])
    
    timesheet = Timesheet.last
    expect(timesheet.approved).to eq false
  end    

  it "verifies if existing and approved timesheet can be unapproved - take 2" do
    post :create, params: subject
    timesheet = Timesheet.last
    Timesheet.update(timesheet[:id], approved: 1).save(:validate => false)

    post :unapprove, params: { timesheet_id: timesheet[:id] }
    expect(response).to redirect_to root_path
    expect(flash[:success]).to eq format('Successfully unapproved timesheet with id %s.', timesheet[:id])
    
    timesheet = Timesheet.last
    expect(timesheet.approved).to eq false
  end    

end
