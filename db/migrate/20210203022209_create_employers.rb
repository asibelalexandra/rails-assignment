class CreateEmployers < ActiveRecord::Migration[6.0]
  def change
    create_table :employers do |t|
      t.string :employer_name

      t.timestamps
    end
  end
end
