class CreateMaterialPackages < ActiveRecord::Migration
  def self.up
    create_table :material_packages do |t|
      t.integer :work_process_id
      t.string :unit_number
      t.string :load_number
      t.string :gate_number
      t.string :crane_number
      t.datetime :planned_delivery_date
      t.integer :craning_time
      t.datetime :ordered_delivery_date
      t.string :delivery_conditions
      t.string :return_policy

      t.timestamps
    end
  end

  def self.down
    drop_table :material_packages
  end
end
