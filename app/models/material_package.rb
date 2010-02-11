class MaterialPackage < ActiveRecord::Base
  attr_accessible :unit_number,
                  :load_number,
                  :gate_number,
                  :crane_number,
                  :planned_delivery_date,
                  :craning_time,
                  :ordered_delivery_date,
                  :delivery_conditions,
                  :return_policy,
                  :materials_attributes

  belongs_to :work_process
  has_many :materials
  
  accepts_nested_attributes_for :materials, :allow_destroy => true
end
