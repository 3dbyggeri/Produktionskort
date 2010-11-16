class ModifyAssemblyDirectionFieldLength < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE work_processes ALTER COLUMN assembly_direction TYPE text;"
  end

  def self.down
    raise "no going back"
  end
end
