class AddCounterToOptions < ActiveRecord::Migration
  def self.up
      add_column :options, :open_interest, :integer, :default => 0
  end

  def self.down
      remove_column :options, :open_interest
  end
end
