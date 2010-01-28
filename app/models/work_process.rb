class WorkProcess < ActiveRecord::Base
  belongs_to :project
  has_many :companies, :dependent => :destroy
  has_many :equipment, :dependent => :destroy
  has_many :inspections, :dependent => :destroy
  has_many :material_packages, :dependent => :destroy
  has_many :preconditions, :dependent => :destroy
  has_many :protections, :dependent => :destroy
  has_many :qualifications, :dependent => :destroy
  has_many :requirements, :dependent => :destroy
  has_many :wasted_times, :dependent => :destroy
  has_many :activity_referrals, :dependent => :destroy
  has_many :work_method_referrals, :dependent => :destroy
  has_many :crew_referrals, :dependent => :destroy
  has_many :material_referrals, :dependent => :destroy
  has_many :equipment_referrals, :dependent => :destroy
  
  accepts_nested_attributes_for :project
  accepts_nested_attributes_for :companies, :allow_destroy => true
  # accepts_nested_attributes_for :equipment, 
  #                               :inspections, 
  #                               :material_packages, 
  #                               :preconditions, 
  #                               :protections, 
  #                               :qualifications, 
  #                               :requirements, 
  #                               :wasted_times, 
  #                               :activity_referrals, 
  #                               :work_method_referrals,
  #                               :crew_referrals, 
  #                               :material_referrals, 
  #                               :equipment_referrals,
  #                               :allow_destroy => true
  
  validates_presence_of :project
  
end
