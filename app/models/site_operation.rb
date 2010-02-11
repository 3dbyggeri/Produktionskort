class SiteOperation < ActiveRecord::Base
  belongs_to :project

  KINDS = ["Vinterforanstaltning","Indvendig rengøring","Udvendig rengøring","Affaldssortering","Udlejningsservice"]
end
