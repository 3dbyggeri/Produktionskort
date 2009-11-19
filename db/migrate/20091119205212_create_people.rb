class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.integer :company_id
      t.integer :project_id
      t.string :kind
      t.string :name
      t.string :street_address
      t.string :extended_address
      t.integer :postal_code
      t.string :city
      t.string :tel
      t.string :direct_tel
      t.string :mobile_tel
      t.string :fax
      t.string :email
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
