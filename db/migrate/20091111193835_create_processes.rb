class CreateProcesses < ActiveRecord::Migration
  def self.up
    create_table :work_processes do |t|
      t.integer :project_id
      t.string :component_type
      t.string :activity
      t.string :location
      t.datetime :project_delivery_time
      t.string :project_delivery_person
      t.string :assembly_direction
      t.datetime :planned_start
      t.datetime :planned_end
      t.datetime :actual_start
      t.string :actual_start_place
      t.string :actual_start_person
      t.datetime :actual_end
      t.string :actual_end_place
      t.string :actual_end_person
      t.datetime :main_start
      t.datetime :main_end
      t.string :preceding
      t.string :subsequent
      t.string :social_responsibility
      t.decimal :piecework_rate
      t.decimal :hourly_rate
      t.boolean :bonus
      t.boolean :incentive_deal
      t.decimal :allowance
      t.string :time_of_day
      t.boolean :extra_work

      t.timestamps
    end
  end

  def self.down
    drop_table :work_processes
  end
end
