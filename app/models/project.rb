class Project < ActiveRecord::Base
  has_many :work_processes
  has_many :approvals
  has_many :attentions
  has_many :comapnies
  has_many :equipment
  has_many :meetings
  has_many :people
  has_many :site_focus
  has_many :site_operations
  has_many :site_responsibilities
  has_many :planning_referrals
  has_many :site_referrals
  
end
