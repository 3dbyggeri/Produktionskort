class CreateApprovals < ActiveRecord::Migration
  def self.up
    create_table :approvals do |t|
      t.integer :project_id
      t.string :kind
      t.string :description
      t.string :time

      t.timestamps
    end
  end

  def self.down
    drop_table :approvals
  end
end
