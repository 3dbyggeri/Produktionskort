class CreateQualifications < ActiveRecord::Migration
  def self.up
    create_table :qualifications do |t|
      t.integer :work_process_id
      t.string :type
      t.string :kind
      t.string :notes
      t.integer :immaterial_currency

      t.timestamps
    end
  end

  def self.down
    drop_table :qualifications
  end
end
