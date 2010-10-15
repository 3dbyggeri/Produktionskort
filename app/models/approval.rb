# coding: utf-8
class Approval < ActiveRecord::Base
  belongs_to :project

  has_attached_file :attachment,
                    :storage => :s3,
                    :bucket => ENV['S3_BUCKET'],
                    :s3_credentials => { :access_key_id => ENV['S3_KEY'],
                                         :secret_access_key => ENV['S3_SECRET'] },
                    :path => "/:attachment/:id/:filename"

  attr_writer :remove_attachment, :new_attachment_import

  KINDS = ['Byggetilladelse', 'Geoteknisk rapport', 'Statiske beregninger', 'Miljøgodkendelse',
           'Parkeringstilladelse', 'Kranopstilling', 'Anmeldelse til arbejdstilsyn',
           'Anmeldelse til fagforening', 'Brandmyndigheder', 'Certifikater']
end
