# coding: utf-8
class Attention < ActiveRecord::Base
  belongs_to :project

  KINDS = ['Brugere', 'Naboer', 'Hospital', 'Skole', 'Børnehave', 'Plejehjem', 'Trafikken']
end
