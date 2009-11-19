class CreatePreconditions < ActiveRecord::Migration
  def self.up
    create_table :preconditions do |t|
      t.integer :work_process_id
      t.string :kind
      t.string :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :preconditions
  end
end
