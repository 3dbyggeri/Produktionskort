class Attention < ActiveRecord::Base
  belongs_to :project

  KINDS = %w[Beboere Hospital Skole Børnehave Plejehjem Trafikken]
end
