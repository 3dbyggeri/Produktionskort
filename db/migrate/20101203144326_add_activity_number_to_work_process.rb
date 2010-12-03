class AddActivityNumberToWorkProcess < ActiveRecord::Migration
  def self.up
    add_column :work_processes, :activity_number, :string
  end

  def self.down
    remove_column :work_processes, :activity_number
  end
end
