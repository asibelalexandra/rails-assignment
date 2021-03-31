class Budget < ApplicationRecord
  belongs_to :employer
  has_many :timesheet, dependent: :delete_all
  validates :budget_name, presence: true, length: { maximum: 50 }, allow_blank: false
  validates :hours, presence: true, allow_blank: false
  #validates_numericality_of adaugat dupa teste
  validates_numericality_of :hours, :greater_than_or_equal_to => 1
  validates :start_date, presence: true, allow_blank: false
  validates :end_date, presence: true, allow_blank: false
  validate :start_date_is_before_end_date

  def start_date_is_before_end_date
    errors.add(:start_date, 'must be before End date') if !start_date.blank? && !end_date.blank? && start_date >= end_date
  end
end
