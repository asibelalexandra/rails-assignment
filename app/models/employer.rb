class Employer < ApplicationRecord
  has_many :employees, dependent: :delete_all
  has_many :budgets, dependent: :delete_all
  validates :employer_name, presence: true, length: { maximum: 50 }, allow_blank: false
end
