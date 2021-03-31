require 'rails_helper'

RSpec.describe Employee, type: :model do

  before do
    @common_employer = Employer.new(employer_name: "Test_Employer")
    @common_employer.save
  end

  subject {
    described_class.new(first_name: "Test", last_name: "Test", employer: @common_employer)
  }

  describe "Validations" do
    it "should save employee with proper values" do
      expect(subject).to be_valid
    end

    it "should not save employee with empty first name" do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it "should not save employee with empty last name" do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

    it "should not save employee with empty employer" do
      subject.employer = nil
      expect(subject).to_not be_valid
    end

    #TODO employee first_name/last_name length tests
  end
end

