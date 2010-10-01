# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101001012606) do

  create_table "approvals", :force => true do |t|
    t.integer  "project_id"
    t.string   "kind"
    t.string   "description"
    t.string   "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attentions", :force => true do |t|
    t.integer  "project_id"
    t.string   "kind"
    t.string   "description"
    t.string   "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", :force => true do |t|
    t.integer  "project_id"
    t.integer  "work_process_id"
    t.string   "kind"
    t.string   "name"
    t.integer  "postal_code"
    t.string   "city"
    t.string   "tel"
    t.string   "fax"
    t.string   "email"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documentations", :force => true do |t|
    t.integer  "inspection_id"
    t.string   "kind"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "equipment", :force => true do |t|
    t.integer  "project_id"
    t.integer  "work_process_id"
    t.string   "role"
    t.string   "person"
    t.string   "kind"
    t.string   "notes"
    t.string   "manual"
    t.string   "location"
    t.string   "requirements"
    t.string   "certificate"
    t.string   "deal_rental"
    t.string   "contract_service"
    t.string   "registration"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "inspection"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inspections", :force => true do |t|
    t.integer  "work_process_id"
    t.string   "kind"
    t.string   "method"
    t.string   "notes"
    t.string   "person"
    t.datetime "time"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "material_packages", :force => true do |t|
    t.integer  "work_process_id"
    t.string   "unit_number"
    t.string   "load_number"
    t.string   "gate_number"
    t.string   "crane_number"
    t.datetime "planned_delivery_date"
    t.integer  "craning_time"
    t.datetime "ordered_delivery_date"
    t.string   "delivery_conditions"
    t.string   "return_policy"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "materials", :force => true do |t|
    t.integer  "material_package_id"
    t.string   "kind"
    t.string   "area_of_appliance"
    t.string   "measures"
    t.string   "weight"
    t.string   "colors"
    t.string   "tolerances"
    t.string   "performance"
    t.string   "chemical_conditions"
    t.string   "count"
    t.string   "lengths"
    t.string   "unit"
    t.string   "delivery_time_stock"
    t.string   "delivery_time_order"
    t.boolean  "storage"
    t.boolean  "dry"
    t.string   "assembly_inspection"
    t.string   "datasheets"
    t.string   "special_tools"
    t.string   "facility_management"
    t.integer  "supplier"
    t.integer  "alternative_supplier"
    t.string   "delivery_conditions"
    t.string   "return_policy"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meetings", :force => true do |t|
    t.integer  "project_id"
    t.string   "kind"
    t.string   "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.integer  "company_id"
    t.integer  "project_id"
    t.string   "kind"
    t.string   "name"
    t.string   "street_address"
    t.string   "extended_address"
    t.integer  "postal_code"
    t.string   "city"
    t.string   "tel"
    t.string   "direct_tel"
    t.string   "mobile_tel"
    t.string   "fax"
    t.string   "email"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "preconditions", :force => true do |t|
    t.integer  "work_process_id"
    t.string   "kind"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "title_number"
    t.string   "postal_code"
    t.string   "apv_location"
    t.boolean  "health_safety_decided_by_owner"
    t.boolean  "health_safety_decided_by_contractor"
    t.boolean  "health_safety_plan"
    t.string   "health_safety_plan_location"
    t.string   "bips_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "byggeweb_project"
  end

  create_table "protections", :force => true do |t|
    t.integer  "work_process_id"
    t.string   "kind"
    t.string   "notes"
    t.string   "usage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "qualifications", :force => true do |t|
    t.integer  "work_process_id"
    t.string   "kind"
    t.string   "notes"
    t.integer  "immaterial_currency"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "super_kind"
  end

  create_table "referrals", :force => true do |t|
    t.integer  "project_id"
    t.integer  "work_process_id"
    t.string   "type"
    t.string   "kind"
    t.string   "notes"
    t.string   "identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  create_table "requirements", :force => true do |t|
    t.integer  "work_process_id"
    t.string   "kind"
    t.string   "component"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_focuses", :force => true do |t|
    t.integer  "project_id"
    t.string   "kind"
    t.string   "description"
    t.datetime "last_inspection"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_operations", :force => true do |t|
    t.integer  "project_id"
    t.string   "kind"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_responsibilities", :force => true do |t|
    t.integer  "project_id"
    t.integer  "company_id"
    t.string   "person"
    t.string   "kind"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "byggeweb_username"
    t.string   "byggeweb_password"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "wasted_times", :force => true do |t|
    t.integer  "work_process_id"
    t.string   "caused_by"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "work_processes", :force => true do |t|
    t.integer  "project_id"
    t.string   "component_type"
    t.string   "activity"
    t.string   "location"
    t.datetime "project_delivery_time"
    t.string   "project_delivery_person"
    t.string   "assembly_direction"
    t.datetime "planned_start"
    t.datetime "planned_end"
    t.datetime "actual_start"
    t.string   "actual_start_place"
    t.string   "actual_start_person"
    t.datetime "actual_end"
    t.string   "actual_end_place"
    t.string   "actual_end_person"
    t.datetime "main_start"
    t.datetime "main_end"
    t.string   "preceding"
    t.string   "subsequent"
    t.string   "social_responsibility"
    t.decimal  "piecework_rate"
    t.decimal  "hourly_rate"
    t.boolean  "bonus"
    t.boolean  "incentive_deal"
    t.decimal  "allowance"
    t.string   "time_of_day"
    t.boolean  "extra_work"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
