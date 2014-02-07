class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.text :description
      t.integer :amount
      t.integer :movement_id
      t.integer :pocket_id
      t.integer :user_id

      t.timestamps
    end
  end
end
