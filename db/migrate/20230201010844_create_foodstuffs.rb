class CreateFoodstuffs < ActiveRecord::Migration[6.1]
  def change
    create_table :foodstuffs do |t|
      t.string :name
      t.integer :amount
      t.integer :user_id
      t.timestamps
    end
  end
end
