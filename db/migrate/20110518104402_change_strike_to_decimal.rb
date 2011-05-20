class ChangeStrikeToDecimal < ActiveRecord::Migration
  def self.up
      change_column :options, :strike, :decimal
  end

  def self.down
      change_column :options, :strike, :integer
  end
end
