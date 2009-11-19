class Equipment < ActiveRecord::Base
  belongs_to :project
  belongs_to :work_process
end
