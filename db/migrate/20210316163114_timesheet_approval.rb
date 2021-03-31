class TimesheetApproval < ActiveRecord::Migration[6.0]
  def change
    add_column(:timesheets, :approved, :boolean, :default => false)
  end
end
