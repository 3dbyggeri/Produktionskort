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
  has_many :activity_referrals, :dependent => :destroy
  has_many :work_method_referrals, :dependent => :destroy
  has_many :crew_referrals, :dependent => :destroy
  has_many :material_referrals, :dependent => :destroy
  has_many :equipment_referrals, :dependent => :destroy

  accepts_nested_attributes_for :companies,
                                :equipment,
                                :inspections,
                                :preconditions,
                                :protections,
                                :qualifications,
                                :requirements,
                                :activity_referrals,
                                :work_method_referrals,
                                :equipment_referrals,
                                :material_packages,
                                :material_referrals,
                                :crew_referrals, :allow_destroy => true
  
  validates_presence_of :project

  def to_xml_deep
    to_xml(
      :include => {
        :project => {},
        :companies => {},
        :equipment => {},
        :inspections => { :include => :documentations },
        :preconditions => {},
        :protections => {},
        :qualifications => {},
        :requirements => {},
        :activity_referrals => {},
        :work_method_referrals => {},
        :equipment_referrals => {},
        :material_packages => { :include => :materials },
        :material_referrals => {},
        :crew_referrals => {}
      }
    )
  end

  def attachments
    (project.planning_referrals +
     project.site_referrals +
     project.approvals +
     activity_referrals +
     equipment_referrals +
     material_referrals +
     crew_referrals).reject { |m| m.attachment_file_name.blank? }
  end
end
