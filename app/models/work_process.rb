class WorkProcess < ActiveRecord::Base
  belongs_to :project
  
  validates_presence_of :project
end