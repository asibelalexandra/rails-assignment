require 'rails_helper'

RSpec.describe Budget, type: :model do

  before do
    @common_employer = Employer.new(employer_name: "Test_Employer")
    @common_employer.save
  end

  subject {
    described_class.new(budget_name: "Test", hours: 1, start_date: "2021-01-01", end_date: "2021-01-02", employer: @common_employer)
  }

  describe "Validations" do
    it "should save budget with proper values" do
      expect(subject).to be_valid
    end

    it "should not save budget without employer" do
      subject.employer = nil
      expect(subject).to_not be_valid
    end

    it "should not save budget without name" do
      subject.budget_name = nil
      expect(subject).to_not be_valid
    end

    it "should not save budget without hours" do
      subject.hours = nil
      expect(subject).to_not be_valid
    end

    it "should not save budget with negative hours" do
      subject.hours = -1
      expect(subject).to_not be_valid
    end

    it "should not save budget without start date" do
      subject.start_date = nil
      expect(subject).to_not be_valid
    end

    it "should not save budget without end date" do
      subject.end_date = nil
      expect(subject).to_not be_valid
    end

    it "should not save budget with start date before end date" do
      subject.start_date = "2021-01-02"
      subject.end_date = "2021-01-01"
      expect(subject).to_not be_valid
    end
  end
end
