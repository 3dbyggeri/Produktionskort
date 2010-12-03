class AddSupplierToMaterialPackage < ActiveRecord::Migration
  def self.up
    add_column :material_packages, :supplier, :string
  end

  def self.down
    remove_column :material_packages, :supplier
  end
end
