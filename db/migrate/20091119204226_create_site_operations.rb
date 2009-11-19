class CreateSiteOperations < ActiveRecord::Migration
  def self.up
    create_table :site_operations do |t|
      t.integer :project_id
      t.string :kind
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :site_operations
  end
end
