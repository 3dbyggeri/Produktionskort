class CreateEquipment < ActiveRecord::Migration
  def self.up
    create_table :equipment do |t|
      t.integer :project_id
      t.integer :work_process_id
      t.string :role
      t.string :person
      t.string :kind
      t.string :notes
      t.string :manual
      t.string :location
      t.string :requirements
      t.string :certificate
      t.string :deal_rental
      t.string :contract_service
      t.string :registration
      t.datetime :start_time
      t.datetime :end_time
      t.string :inspection

      t.timestamps
    end
  end

  def self.down
    drop_table :equipment
  end
end
