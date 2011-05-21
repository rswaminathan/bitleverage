class CreateWithdrawalRequests < ActiveRecord::Migration
  def self.up
    create_table :withdrawal_requests do |t|
      t.decimal :funds, :precision => 16, :scale => 4
      t.string :typ
      t.string :address
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :withdrawal_requests
  end
end
