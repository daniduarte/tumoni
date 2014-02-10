class AddUserIdToPocket < ActiveRecord::Migration
  def change
    add_column :pockets, :user_id, :integer
  end
end
