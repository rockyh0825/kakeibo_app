class CreateSalaries < ActiveRecord::Migration[6.1]
  def change
    create_table :salaries do |t|
      t.integer :price
      t.date :day
      t.integer :user_id

      t.timestamps
    end
  end
end
