class AddLastValueToOptions < ActiveRecord::Migration
  def self.up
      add_column :options, :value, :decimal
  end

  def self.down
      remove_column :options, :value
  end
end
