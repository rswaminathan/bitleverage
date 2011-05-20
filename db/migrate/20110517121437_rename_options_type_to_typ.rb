class RenameOptionsTypeToTyp < ActiveRecord::Migration
  def self.up
      rename_column :options, :type, :typ
  end

  def self.down
  end
end
