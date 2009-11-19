class CreateMaterials < ActiveRecord::Migration
  def self.up
    create_table :materials do |t|
      t.integer :material_package_id
      t.string :kind
      t.string :area_of_appliance
      t.string :measures
      t.string :weight
      t.string :colors
      t.string :tolerances
      t.string :performance
      t.string :chemical_conditions
      t.string :count
      t.string :lengths
      t.string :unit
      t.string :delivery_time_stock
      t.string :delivery_time_order
      t.boolean :storage
      t.boolean :dry
      t.string :assembly_inspection
      t.string :datasheets
      t.string :special_tools
      t.string :facility_management
      t.integer :supplier
      t.integer :alternative_supplier
      t.string :delivery_conditions
      t.string :return_policy

      t.timestamps
    end
  end

  def self.down
    drop_table :materials
  end
end
