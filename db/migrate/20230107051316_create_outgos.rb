class CreateOutgos < ActiveRecord::Migration[6.1]
  def change
    create_table :outgos do |t|
      t.date :day
      t.string :content
      t.integer :genre_id
      t.integer :user_id
      t.integer :cost
      t.date :start_time

      t.timestamps
    end
  end
end
