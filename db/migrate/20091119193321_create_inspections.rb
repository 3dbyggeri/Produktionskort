class CreateInspections < ActiveRecord::Migration
  def self.up
    create_table :inspections do |t|
      t.integer :work_process_id
      t.string :kind
      t.string :method
      t.string :notes
      t.string :person
      t.datetime :time
      t.string :location

      t.timestamps
    end
  end

  def self.down
    drop_table :inspections
  end
end
