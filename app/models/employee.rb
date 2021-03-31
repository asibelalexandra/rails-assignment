class Employee < ApplicationRecord
  belongs_to :employer
  has_many :timesheet
  validates :first_name, presence: true, length: { maximum: 50 }, allow_blank: false
  validates :last_name, presence: true, length: { maximum: 50 }, allow_blank: false
  #
  # camp:
  #   - null - validates_presence_of
  #   - 'a'
  #   - '' - allow_blank: false

  def full_name
    "#{first_name} #{last_name}"
  end
end
