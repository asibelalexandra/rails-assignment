class StaticPagesController < ApplicationController
  def home
    @latest_employees = Employee.last(5)
    @latest_employers = Employer.last(5)
    @latest_budgets = Budget.last(5)
    @latest_timesheets = Timesheet.last(5)
  end
end
