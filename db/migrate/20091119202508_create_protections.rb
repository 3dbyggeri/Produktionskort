class CreateProtections < ActiveRecord::Migration
  def self.up
    create_table :protections do |t|
      t.integer :work_process_id
      t.string :kind
      t.string :notes
      t.string :usage

      t.timestamps
    end
  end

  def self.down
    drop_table :protections
  end
end
