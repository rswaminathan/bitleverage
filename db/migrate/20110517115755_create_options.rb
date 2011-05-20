class CreateOptions < ActiveRecord::Migration
  def self.up
    create_table :options do |t|
      t.string :type
      t.integer :quantity
      t.integer :strike
      t.datetime :expiration

      t.timestamps
    end
  end

  def self.down
    drop_table :options
  end
end
