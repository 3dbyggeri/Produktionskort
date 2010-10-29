class MaterialPackage < ActiveRecord::Base
  belongs_to :work_process
  has_many :materials
  
  accepts_nested_attributes_for :materials, :allow_destroy => true
end
