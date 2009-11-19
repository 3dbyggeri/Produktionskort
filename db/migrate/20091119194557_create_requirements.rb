class CreateRequirements < ActiveRecord::Migration
  def self.up
    create_table :requirements do |t|
      t.integer :work_process_id
      t.string :kind
      t.string :component
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :requirements
  end
end
