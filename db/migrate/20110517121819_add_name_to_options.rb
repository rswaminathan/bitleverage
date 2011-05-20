class AddNameToOptions < ActiveRecord::Migration
  def self.up
      add_column :options, :name, :string
  end

  def self.down
  end
end
