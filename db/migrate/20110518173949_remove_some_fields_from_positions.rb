class RemoveSomeFieldsFromPositions < ActiveRecord::Migration
  def self.up
      remove_column :positions, :current_val
  end

  def self.down
      add_column :positions, :current_val, :decimal
  end
end
