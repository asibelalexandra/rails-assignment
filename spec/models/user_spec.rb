require 'rails_helper'

RSpec.describe User, type: :model do

  subject {
    described_class.new(first_name: "it", last_name: "it", email: "alexandra@gmail.com", password: "it1234!")
  }

  it "should save user with proper values" do
    expect(subject).to be_valid
  end

  it "should not save user with empty email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "should not save user with invalid email" do
    subject.email = "alexandra@gmail"
    expect(subject).to_not be_valid
  end

  it "should not save user with empty password" do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it "should not save user with empty first name" do
    subject.first_name = nil
    expect(subject).to_not be_valid
  end

  it "should not save user with empty last name" do
    subject.last_name = nil
    expect(subject).to_not be_valid
  end

  it "should not save user with an email that has more than 255 chars" do
    subject.email = rand(36**256).to_s(36) + "@gmail.com"
    expect(subject).to_not be_valid
  end

  it "should not save user with a first name greater than 50 chars" do
    subject.first_name = rand(36**51).to_s(36)
    expect(subject).to_not be_valid
  end

  it "should not save user with a last name greater than 50 chars" do
    subject.last_name = rand(36**51).to_s(36)
    expect(subject).to_not be_valid
  end

end
