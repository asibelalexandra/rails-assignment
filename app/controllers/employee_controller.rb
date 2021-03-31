class EmployeeController < ApplicationController
  def new
  end

  def create
    form_params = employee_params

    @employee = Employee.new(form_params)
    if @employee.save
      redirect_to employee_index_path
      flash[:success] = format(
        'Successfully added employee %s %s with id %d.',
        form_params[:first_name],
        form_params[:last_name],
        @employee.id
      )
    else
      render :new
    end
  end

  def index
    @employees = Employee.all
  end

  def show
    @employee = Employee.find(params[:id])
    @timesheets = Timesheet.where(employee_id: @employee.id)
  end

  private
  def employee_params
    params.permit(:first_name, :last_name, :employer_id)
  end
end
