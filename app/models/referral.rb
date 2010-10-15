class Referral < ActiveRecord::Base
  has_attached_file :attachment,
                    :storage => :s3,
                    :bucket => ENV['S3_BUCKET'],
                    :s3_credentials => { :access_key_id => ENV['S3_KEY'],
                                         :secret_access_key => ENV['S3_SECRET'] },
                    :path => "/:attachment/:id/:filename"

  attr_writer :remove_attachment, :new_attachment_import

  class << self
    def kinds
      raise "Override this!"
    end
  end
end
