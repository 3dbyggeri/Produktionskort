class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.integer :project_id
      t.integer :work_process_id
      t.string :kind
      t.string :name
      t.integer :postal_code
      t.string :city
      t.string :tel
      t.string :fax
      t.string :email
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
