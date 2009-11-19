class CreateAttentions < ActiveRecord::Migration
  def self.up
    create_table :attentions do |t|
      t.integer :project_id
      t.string :kind
      t.string :description
      t.string :time

      t.timestamps
    end
  end

  def self.down
    drop_table :attentions
  end
end
