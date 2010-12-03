class RemoveFax < ActiveRecord::Migration
  def self.up
    remove_column :companies, :fax
    remove_column :people, :fax
  end

  def self.down
    add_column :companies, :fax, :string
    add_column :people, :fax, :string
  end
end
