class AddByggewebFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :byggeweb_username, :string
    add_column :users, :byggeweb_password, :string
  end

  def self.down
    remove_column :users, :byggeweb_username
    remove_column :users, :byggeweb_password
  end
end
