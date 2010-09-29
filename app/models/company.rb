# coding: utf-8
class Company < ActiveRecord::Base
  belongs_to :project
  belongs_to :work_process
  has_many :people

  KINDS = %w[Bygherre Rådgiver Entreprenør Underentreprenør Fagentreprenør Grossist Leverandør Producent Landmåler Service Arkitekt]
end
