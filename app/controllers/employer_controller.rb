class EmployerController < ApplicationController
  def new
  end

  def create
    form_params = employer_params

    @employer = Employer.new(form_params)
    if @employer.save
      redirect_to employer_index_path
      flash[:success] = format(
        'Successfully added employer %s with id %d.',
        form_params[:employer_name],
        @employer.id
      )
    else
      render 'new'
    end
  end

  def index
    @employers = Employer.all
  end

  def show
    @employer = Employer.find(params[:id])
    @budgets = Budget.where(employer_id: @employer.id)
    @employees = Employee.where(employer_id: @employer.id)
  end

  private
  def employer_params
    params.permit(:employer_name)
  end
end
