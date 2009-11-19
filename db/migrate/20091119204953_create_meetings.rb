class CreateMeetings < ActiveRecord::Migration
  def self.up
    create_table :meetings do |t|
      t.integer :project_id
      t.string :kind
      t.string :time

      t.timestamps
    end
  end

  def self.down
    drop_table :meetings
  end
end
