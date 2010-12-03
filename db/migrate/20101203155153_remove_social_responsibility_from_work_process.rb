class RemoveSocialResponsibilityFromWorkProcess < ActiveRecord::Migration
  def self.up
    remove_column :work_processes, :social_responsibility
  end

  def self.down
    add_column :work_processes, :social_responsibility, :string
  end
end
