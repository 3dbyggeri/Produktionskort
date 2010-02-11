class WorkProcess < ActiveRecord::Base
  attr_accessible :component_type,
                  :activity,
                  :location,
                  :project_delivery_time,
                  :project_delivery_person,
                  :assembly_direction,
                  :planned_start,
                  :planned_end,
                  :actual_start,
                  :actual_start_place,
                  :actual_start_person,
                  :actual_end,
                  :actual_end_place,
                  :actual_end_person,
                  :main_start,
                  :main_end,
                  :preceding,
                  :subsequent,
                  :social_responsibility,
                  :piecework_rate,
                  :hourly_rate,
                  :bonus,
                  :incentive_deal,
                  :allowance,
                  :time_of_day,
                  :extra_work,
                  :project_attributes,
                  :companies_attributes,
                  :equipment_attributes,
                  :inspections_attributes,
                  :material_packages_attributes,
                  :preconditions_attributes,
                  :protections_attributes,
                  :qualifications_attributes,
                  :requirements_attributes,
                  :wasted_times_attributes,
                  :activity_referrals_attributes,
                  :work_method_referrals_attributes,
                  :crew_referrals_attributes,
                  :material_referrals_attributes,
                  :equipment_referrals_attributes
  
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
  accepts_nested_attributes_for :companies,
                                :equipment, 
                                :inspections, 
                                :material_packages, 
                                :preconditions, 
                                :protections, 
                                :qualifications, 
                                :requirements, 
                                :wasted_times, 
                                :activity_referrals, 
                                :work_method_referrals,
                                :crew_referrals, 
                                :material_referrals, 
                                :equipment_referrals,
                                :allow_destroy => true
  
  validates_presence_of :project
  
end
