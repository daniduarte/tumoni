class AddPocketIdToMovements < ActiveRecord::Migration
  def change
    add_column :movements, :pocket_id, :integer
  end
end
