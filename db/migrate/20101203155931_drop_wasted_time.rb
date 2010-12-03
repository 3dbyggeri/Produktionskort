class DropWastedTime < ActiveRecord::Migration
  def self.up
    drop_table :wasted_times

    remove_column :work_processes, :actual_start
    remove_column :work_processes, :actual_start_place
    remove_column :work_processes, :actual_start_person
    remove_column :work_processes, :actual_end
    remove_column :work_processes, :actual_end_place
    remove_column :work_processes, :actual_end_person
  end

  def self.down
    create_table :wasted_times do |t|
      t.integer :work_process_id
      t.string :caused_by
      t.datetime :start
      t.datetime :end

      t.timestamps
    end

    add_column :work_processes, :actual_start, :datetime
    add_column :work_processes, :actual_start_place, :string
    add_column :work_processes, :actual_start_person, :string
    add_column :work_processes, :actual_end, :datetime
    add_column :work_processes, :actual_end_place, :string
    add_column :work_processes, :actual_end_person, :string
  end
end
