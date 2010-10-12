# coding: utf-8
class Approval < ActiveRecord::Base
  belongs_to :project

  has_attached_file :attachment,
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root.to_s}/config/amazon_s3.yml",
                    :path => "/:attachment/:id/:filename"

  attr_writer :remove_attachment, :new_attachment_import

  KINDS = ['Byggetilladelse', 'Geoteknisk rapport', 'Statiske beregninger', 'Miljøgodkendelse',
           'Parkeringstilladelse', 'Kranopstilling', 'Anmeldelse til arbejdstilsyn',
           'Anmeldelse til fagforening', 'Brandmyndigheder', 'Certifikater']
end
