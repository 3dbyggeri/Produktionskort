class AddByggewebProjectToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :byggeweb_project, :string
  end

  def self.down
    remove_column :projects, :byggeweb_project
  end
end
