class AddUserIdToTrades < ActiveRecord::Migration
  def self.up
      add_column :trades, :user_id, :integer
  end

  def self.down
      remove_column :trades, :user_id
  end
end
