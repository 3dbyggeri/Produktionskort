class MaterialPackage < ActiveRecord::Base
  belongs_to :work_process
  has_many :materials
end
