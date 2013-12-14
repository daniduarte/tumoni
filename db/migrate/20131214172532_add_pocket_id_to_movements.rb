class AddPocketIdToMovements < ActiveRecord::Migration
  def change
    add_column :movements, :pocket_id, :integen
  end
end
