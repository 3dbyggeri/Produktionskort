class CreateWastedTimes < ActiveRecord::Migration
  def self.up
    create_table :wasted_times do |t|
      t.integer :work_process_id
      t.string :caused_by
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end

  def self.down
    drop_table :wasted_times
  end
end
