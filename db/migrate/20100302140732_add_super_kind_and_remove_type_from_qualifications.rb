class AddSuperKindAndRemoveTypeFromQualifications < ActiveRecord::Migration
  def self.up
    remove_column :qualifications, :type
    add_column :qualifications, :super_kind, :string
  end

  def self.down
    remove_column :qualifications, :super_kind
    add_column :qualifications, :type, :string
  end
end
