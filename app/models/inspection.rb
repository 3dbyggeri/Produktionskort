class Inspection < ActiveRecord::Base
  belongs_to :work_process
  has_many :documentations
end
