class Company < ActiveRecord::Base
  belongs_to :project
  belongs_to :work_process
  has_many :people
end
