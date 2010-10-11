class PlanningReferral < Referral
  belongs_to :project

  class << self
    def kinds
      ['Tegning', 'Referencenavn', 'Detaljetegning', 'Beskrivelse', 'Tidsplan', 'Mockup',
       'Kalkullation', 'Tilbudsliste', 'Budget', 'KS', 'Adgangskontrol']
    end
  end
end
