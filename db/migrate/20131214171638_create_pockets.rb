class CreatePockets < ActiveRecord::Migration
  def change
    create_table :pockets do |t|
      t.text :name

      t.timestamps
    end
  end
end
