class CreateMovements < ActiveRecord::Migration
  def change
    create_table :movements do |t|
      t.text :description
      t.integer :amount

      t.timestamps
    end
  end
end
