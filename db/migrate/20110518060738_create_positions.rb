class CreatePositions < ActiveRecord::Migration
  def self.up
    create_table :positions do |t|
      t.integer :user_id
      t.decimal :price
      t.integer :amount
      t.string :instrument
      t.integer :instrument_id
      t.string :typ
      t.decimal :current_val
      t.decimal :pl

      t.timestamps
    end
  end

  def self.down
    drop_table :positions
  end
end
