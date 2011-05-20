class AddUnderlyingToOption < ActiveRecord::Migration
  def self.up
      add_column :options, :underlying, :string
      add_column :options, :underlying_id, :integer
  end

  def self.down
      remove_column :options, :underlying
      remove_column :optiosn, :underlying_id
  end
end
