class RenameUserIdToPortfolioIdInPosition < ActiveRecord::Migration
  def self.up
      rename_column :positions, :user_id, :portfolio_id
  end

  def self.down
      rename_column :positions, :portfolio_id, :user_id
  end
end
