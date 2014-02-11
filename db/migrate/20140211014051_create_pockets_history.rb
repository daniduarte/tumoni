class CreatePocketsHistory < ActiveRecord::Migration
  def change
    create_table :pockets_histories do |t|
      t.text :name
      t.integer :pocket_id
      t.integer :user_id
      t.integer :action_id

      t.timestamps
    end
  end
end
