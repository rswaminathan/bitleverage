class ChangePrecisionOfDecimals < ActiveRecord::Migration
  def self.up
      change_column :transactions, :price, :decimal, :precision => 16, :scale => 4
      change_column :trades, :price, :decimal, :precision => 16, :scale => 4
      change_column :portfolios, :funds, :decimal, :precision => 16, :scale => 4
      change_column :currencies, :value, :decimal, :precision => 16, :scale => 4
      change_column :positions, :price, :decimal, :precision => 16, :scale => 4
      change_column :positions, :pl, :decimal, :precision => 16, :scale => 4
      change_column :options, :value, :decimal, :precision => 16, :scale => 4
      change_column :options, :strike, :decimal, :precision => 16, :scale => 4
  end

  def self.down
      change_column :transactions, :price, :decimal
      change_column :trades, :price, :decimal
      change_column :portfolios, :funds, :decimal
      change_column :currencies, :value, :decimal
      change_column :positions, :price, :decimal
      change_column :positions, :pl, :decimal
      change_column :options, :value, :decimal
      change_column :options, :strike, :decimal
  end
end
