class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.integer :buyer_id
      t.integer :seller_id
      t.decimal :price
      t.string :instrument
      t.integer :instrument_id

      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
