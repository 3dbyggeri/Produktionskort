class Equipment < ActiveRecord::Base
  belongs_to :project
  belongs_to :work_process

  KINDS = %w[Kran Mobilkran Stillads Fællesmateriel Hejs Arbejdsplatform Lift]
end
