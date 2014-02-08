class CreateMovementHistories < ActiveRecord::Migration
  def change
    create_table :movement_histories do |t|
      t.text :description
      t.integer :amount
      t.integer :movement_id
      t.integer :pocket_id
      t.integer :user_id

      t.timestamps
    end
  end
end
