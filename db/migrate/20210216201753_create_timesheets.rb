class CreateTimesheets < ActiveRecord::Migration[6.0]
  def change
    create_table :timesheets do |t|
      t.integer :hours
      t.date :date_of_service

      t.timestamps
    end
  end
end
