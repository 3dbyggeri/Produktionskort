class Documentation < ActiveRecord::Base
  KINDS = %w[Billede]
  belongs_to :inspection
end
