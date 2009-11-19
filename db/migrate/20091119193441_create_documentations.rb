class CreateDocumentations < ActiveRecord::Migration
  def self.up
    create_table :documentations do |t|
      t.integer :inspection_id
      t.string :kind
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :documentations
  end
end
