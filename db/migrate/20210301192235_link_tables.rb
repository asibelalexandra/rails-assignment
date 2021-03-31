class LinkTables < ActiveRecord::Migration[6.0]
  def change
    add_column(:employees, :employer_id,:integer)
    add_foreign_key(:employees, :employers, on_delete: :cascade)

    add_column(:budgets, :employer_id,:integer)
    add_foreign_key(:budgets, :employers, on_delete: :cascade)

    add_column(:timesheets, :employee_id,:integer)
    add_foreign_key(:timesheets, :employees, on_delete: :cascade)

    add_column(:timesheets, :budget_id,:integer)
    add_foreign_key(:timesheets, :budgets, on_delete: :cascade)
  end
end
