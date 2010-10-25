class AddValueAndUnitToWorkProcess < ActiveRecord::Migration
  def self.up
    add_column :work_processes, :unit, :string
    add_column :work_processes, :value, :string
  end

  def self.down
    remove_column :work_processes, :value
    remove_column :work_processes, :unit
  end
end
