class CreateTrades < ActiveRecord::Migration
  def self.up
    create_table :trades do |t|
      t.string :typ
      t.decimal :price
      t.integer :amount
      t.string :order
      t.string :instrument
      t.integer :instrument_id

      t.timestamps
    end
  end

  def self.down
    drop_table :trades
  end
end
