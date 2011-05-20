class AddCounterCacheToCurrency < ActiveRecord::Migration
  def self.up
      add_column :currencies, :open_interest, :integer, :default => 0
  end

  def self.down
      remove_column :currencies, :open_interest
  end
end
