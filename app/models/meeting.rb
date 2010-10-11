# coding: utf-8
class Meeting < ActiveRecord::Base
  belongs_to :project
  
  KINDS = ["Projektgennemgangsmøde", "Opstartsmøde", "Byggemøde", "Formandsmøde",
           "Sikkerhedsmøde", "Uge / Produktionsmøde"]
end
