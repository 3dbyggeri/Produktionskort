# coding: utf-8
class Referral < ActiveRecord::Base
  has_attached_file :attachment,
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root.to_s}/config/amazon_s3.yml",
                    :path => "/:attachment/:id/:filename"

  attr_writer :remove_attachment

  KINDS = ["Tegning","3-D model/objekter","Referencenavn","Detaljetegning","Beskrivelse","Tidsplan","Mockup","Følgeseddel","Faktura","Returseddel","Produktcertificat"]
end
