class Material < ActiveRecord::Base
  attr_accessible :kind,
                  :area_of_appliance,
                  :measures,
                  :weight,
                  :colors,
                  :tolerances,
                  :performance,
                  :chemical_conditions,
                  :count,
                  :lengths,
                  :unit,
                  :delivery_time_stock,
                  :delivery_time_order,
                  :storage,
                  :dry,
                  :assembly_inspection,
                  :datasheets,
                  :special_tools,
                  :facility_management,
                  :supplier,
                  :alternative_supplier,
                  :delivery_conditions,
                  :return_policy

  belongs_to :material_package
end
