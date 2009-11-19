class CreateSiteFocus < ActiveRecord::Migration
  def self.up
    create_table :site_focus do |t|
      t.integer :project_id
      t.string :kind
      t.string :description
      t.datetime :last_inspection

      t.timestamps
    end
  end

  def self.down
    drop_table :site_focus
  end
end
