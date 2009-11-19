class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.string :address
      t.integer :title_number
      t.string :postal_code
      t.string :apv_location
      t.boolean :health_safety_decided_by_owner
      t.boolean :health_safety_decided_by_contractor
      t.boolean :health_safety_plan
      t.string :health_safety_plan_location
      t.string :bips_id

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
