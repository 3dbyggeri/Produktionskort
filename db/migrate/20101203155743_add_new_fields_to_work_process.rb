class AddNewFieldsToWorkProcess < ActiveRecord::Migration
  def self.up
    add_column :work_processes, :responsible, :string
    add_column :work_processes, :duration, :string
  end

  def self.down
    remove_column :work_processes, :duration
    remove_column :work_processes, :responsible
  end
end
