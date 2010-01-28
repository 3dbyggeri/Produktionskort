class Project < ActiveRecord::Base
  attr_accessible :name, :address, :title_number, :postal_code, :apv_location, :health_safety_decided_by_owner, :health_safety_decided_by_contractor, :health_safety_plan, :health_safety_plan_location
  
  has_many :work_processes, :dependent => :destroy
  has_many :approvals, :dependent => :destroy
  has_many :attentions, :dependent => :destroy
  has_many :companies, :dependent => :destroy
  has_many :equipment, :dependent => :destroy
  has_many :meetings, :dependent => :destroy
  has_many :people, :dependent => :destroy
  has_many :site_focus, :dependent => :destroy
  has_many :site_operations, :dependent => :destroy
  has_many :site_responsibilities, :dependent => :destroy
  has_many :planning_referrals, :dependent => :destroy
  has_many :site_referrals, :dependent => :destroy
  
  accepts_nested_attributes_for :work_processes, 
                                :approvals, 
                                :attentions, 
                                :companies, 
                                :equipment, 
                                :meetings, 
                                :people, 
                                :site_focus, 
                                :site_operations, 
                                :site_responsibilities, 
                                :planning_referrals, 
                                :site_referrals
end
