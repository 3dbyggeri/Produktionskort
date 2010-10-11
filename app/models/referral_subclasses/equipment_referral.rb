# coding: utf-8
class EquipmentReferral < Referral
  belongs_to :work_process

  class << self
    def kinds
      ['Tegning', '3-D model/objekter', 'Referencenavn', 'Detaljetegning', 'Beskrivelse', 'Tidsplan',
       'Mockup', 'Følgeseddel', 'Faktura', 'Returseddel', 'Produktcertificat']
    end
  end
end
