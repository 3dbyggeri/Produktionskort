class WorkProcess < ActiveRecord::Base
  belongs_to :project
  has_many :companies
  has_many :equipment
  has_many :inspections
  has_many :material_packages
  has_many :preconditions
  has_many :protections
  has_many :qualifications
  has_many :requirements
  has_many :wasted_times
  has_many :activity_referrals
  has_many :work_method_referrals
  has_many :crew_referrals
  has_many :material_referrals
  has_many :equipment_referrals
  
  validates_presence_of :project
  
end
