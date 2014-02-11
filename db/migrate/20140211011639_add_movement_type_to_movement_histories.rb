class AddMovementTypeToMovementHistories < ActiveRecord::Migration
  def change
    add_column :movement_histories, :movement_type_id, :integer
  end
end
