class CreateBudgets < ActiveRecord::Migration[6.0]
  def change
    create_table :budgets do |t|
      t.string :budget_name
      t.integer :hours
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
