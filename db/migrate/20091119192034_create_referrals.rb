class CreateReferrals < ActiveRecord::Migration
  def self.up
    create_table :referrals do |t|
      t.integer :project_id
      t.integer :work_process_id
      t.string :type
      t.string :kind
      t.string :notes
      t.string :identifier

      t.timestamps
    end
  end

  def self.down
    drop_table :referrals
  end
end
