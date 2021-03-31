require 'rails_helper'

#https://gist.github.com/eliotsykes/5b71277b0813fbc0df56
RSpec.describe BudgetController, type: :controller do
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

  describe "Validations" do
    before do
      Employer.new(employer_name: "Test").save
      @employer = Employer.last
    end

    subject {
      { employer_id: @employer.id, budget_name: "Test Budget", hours: 10, start_date: "2021-01-01", end_date: "2021-01-30" }
    }

    context "POST #create" do
      it "should add new budget" do
        post :create, params: subject
        expect(response).to redirect_to budget_index_path
      end
    end

    context "GET #show" do
      it "should return a success response" do
        post :create, params: subject
        budget = Budget.last

        get :show, params: { id: budget[:id] }
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:show)
      end
    end

    context "GET #edit" do
      it "should return a success response" do
        post :create, params: subject
        budget = Budget.last

        get :edit, params: { id: budget[:id] }
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:edit)
      end
    end

    context "PUT #update" do
      it "should return a success response" do
        post :create, params: subject
        budget = Budget.last

        put :update, params: { id: budget[:id], budget: subject }
        expect(response).to redirect_to budget_index_path
        expect(flash[:success]).to eq format('Successfully saved budget with id %s.', budget[:id])
      end
    end

    context "DELETE #destroy" do
      it "should return a success response" do
        post :create, params: subject
        budget = Budget.last

        delete :destroy, params: { id: budget[:id] }
        expect(response).to redirect_to root_path
        expect(flash[:success]).to eq format('Successfully deleted budget with id %s.', budget[:id])
      end
    end
  end
end
