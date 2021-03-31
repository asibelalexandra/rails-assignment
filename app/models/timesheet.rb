class Timesheet < ApplicationRecord
  belongs_to :budget
  belongs_to :employee
  validates_presence_of :hours, allow_blank: false
  #validates_numericality_of adaugat dupa teste
  validates_numericality_of :hours, :greater_than_or_equal_to => 1
  validates_presence_of :date_of_service, allow_blank: false
  validate :date_of_service_in_budget_date_range
  validate :budget_is_of_employer
  validate :timesheet_hours_lower_than_budget_total

  private
  def date_of_service_in_budget_date_range
    errors.add(
      :date_of_service, ' is not in Budget date range'
    ) if !date_of_service.blank? && !budget.blank? && (budget.start_date.to_date > date_of_service || date_of_service > budget.end_date.to_date)
  end

  #!employee.blank? adaugat dupa teste
  # find_by(id: budget_id) adaugat dupa teste pentru ca arunca exceptie ActiveRecord::RecordNotFound
  def budget_is_of_employer
    errors.add(
      :budget_id, ' is not of the selected employer'
    ) if !budget.blank? && !employee.blank? && employee.employer.budgets.find_by(id: budget_id).blank?
  end

  def timesheet_hours_lower_than_budget_total
    errors.add(
      :hours, ' is higher than remaining budget hours'
    ) if !budget.blank? && !hours.blank? && Timesheet.where(budget_id: budget_id).sum('hours') + hours > budget.hours
  end
end
