class Referral < ActiveRecord::Base
  has_attached_file :attachment,
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root.to_s}/config/amazon_s3.yml",
                    :path => "/:attachment/:id/:filename"

  attr_writer :remove_attachment

  class << self
    def kinds
      raise "Override this!"
    end
  end
end
