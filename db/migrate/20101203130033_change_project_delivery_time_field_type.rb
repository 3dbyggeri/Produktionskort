class ChangeProjectDeliveryTimeFieldType < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE work_processes ALTER COLUMN project_delivery_time TYPE character varying;"
  end

  def self.down
    raise "no going back"
  end
end
