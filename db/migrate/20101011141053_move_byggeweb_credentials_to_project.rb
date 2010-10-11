class MoveByggewebCredentialsToProject < ActiveRecord::Migration
  def self.up
    remove_column :users, :byggeweb_username
    remove_column :users, :byggeweb_password
    add_column :projects, :byggeweb_username, :string
    add_column :projects, :byggeweb_password, :string
  end

  def self.down
    add_column :users, :byggeweb_username, :string
    add_column :users, :byggeweb_password, :string
    remove_column :projects, :byggeweb_username
    remove_column :projects, :byggeweb_password
  end
end
