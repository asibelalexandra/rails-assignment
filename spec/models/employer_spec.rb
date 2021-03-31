require 'rails_helper'

RSpec.describe Employer, type: :model do

  subject {
    described_class.new(employer_name: "Test")
  }

  it "should save employer with proper values" do
    expect(subject).to be_valid
  end

  it "should not save employer without name" do
    subject.employer_name = nil
    expect(subject).to_not be_valid
  end

  it "should not save employer with name longer than 50 char" do
    subject.employer_name = rand(36**51).to_s(36)
    expect(subject).to_not be_valid
  end
end
