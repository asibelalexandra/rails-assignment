require 'rails_helper'

RSpec.describe Timesheet, type: :model do

  before do
    @common_employer = Employer.new(employer_name: "it_Employer")
    @common_employee = Employee.new(first_name: "it", last_name: "it", employer: @common_employer)
    @common_budget = Budget.new(budget_name: "it", hours: 30, start_date: "2021-01-01T12:00:00Z", end_date: "2021-01-30T12:00:00Z", employer: @common_employer)

    @common_employer.save
    @common_employee.save
    @common_budget.save
  end

  subject {
    described_class.new(hours: 1, date_of_service: "2021-01-01", employee: @common_employee, budget: @common_budget)
  }

  it "should save timesheet with proper values" do
    expect(subject).to be_valid
  end

  it "should not save timesheet with empty hours" do
    subject.hours = nil
    expect(subject).to_not be_valid
  end

  it "should not save timesheet with empty date of service" do
    subject.date_of_service = nil
    expect(subject).to_not be_valid
  end

  it "should not save timesheet not linked to employee" do
    subject.employee = nil
    expect(subject).to_not be_valid
  end

  it "should not save timesheet not linked to budget" do
    subject.budget = nil
    expect(subject).to_not be_valid
  end

  it "should save timesheet if there are remaining budget hours" do
    Timesheet.new(hours: 15, date_of_service: "2021-01-01", employee: @common_employee, budget: @common_budget).save
    subject.hours = 15
    expect(subject).to be_valid
  end

  it "should not save timesheet if hours greater than remaining budget hours" do
    Timesheet.new(hours: 30, date_of_service: "2021-01-01", employee: @common_employee, budget: @common_budget).save
    expect(subject).to_not be_valid
  end

  it "should not save timesheet if date of service outside of budget range" do
    subject.date_of_service = "2021-02-02"
    expect(subject).to_not be_valid
  end

  it "should not save timesheet if budget is not of the same employer as the employee" do
    different_employer = Employer.new(employer_name: "Different_it_Employer")
    different_employer_budget = Budget.new(budget_name: "Different_it", hours: 30, start_date: "2021-01-01T12:00:00Z", end_date: "2021-01-30T12:00:00Z", employer: different_employer)

    different_employer.save
    different_employer_budget.save

    timesheet = Timesheet.new(hours: 1, date_of_service: "2021-02-02", employee: @common_employee, budget: different_employer_budget)
    expect(timesheet).to_not be_valid
  end
end
