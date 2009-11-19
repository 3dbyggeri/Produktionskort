class CreateSiteResponsibilities < ActiveRecord::Migration
  def self.up
    create_table :site_responsibilities do |t|
      t.integer :project_id
      t.integer :company_id
      t.string :person
      t.string :kind
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :site_responsibilities
  end
end
