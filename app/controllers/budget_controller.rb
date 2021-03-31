class BudgetController < ApplicationController
  def new
  end

  def create
    form_params = budget_params_new

    @budget = Budget.new(form_params)
    if @budget.save
      redirect_to budget_index_path
      flash[:success] = format('Successfully added budget with id %d.', @budget.id)
    else
      redirect_back fallback_location: root_path
    end
  end

  def index
    @budgets = Budget.all
  end

  def edit
    @budget = Budget.find(params[:id])
  end

  def update
    form_params = budget_params_edit

    @budget = Budget.update(params[:id], form_params)
    if @budget.save
      redirect_to budget_index_path
      flash[:success] = format('Successfully saved budget with id %d.', @budget.id)
    else
      redirect_back fallback_location: root_path
    end
  end

  def show
    @budget = Budget.find(params[:id])
    @timesheets = Timesheet.where(budget_id: @budget.id)
  end

  def destroy
    Budget.delete(params[:id])
    redirect_back fallback_location: root_path
    flash[:success] = format('Successfully deleted budget with id %d.', params[:id])
  end

  private
  def budget_params_new
    params.permit(:employer_id, :budget_name, :hours, :start_date, :end_date)
  end

  def budget_params_edit
    params.require(:budget).permit(:employer_id, :budget_name, :hours, :start_date, :end_date)
  end

end
