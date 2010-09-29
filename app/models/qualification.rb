# coding: utf-8
class Qualification < ActiveRecord::Base
  SUPER_KINDS = ["Uddannelse", "Arbejdsrelaterede kompetencer","Samarbejdskompetencer","Personlige kompetencer"]
  KINDS = ["Kørekort", "Truckcertificat", "Svejsecertificat","Produktviden asfalt","Produktviden epoxy"]
  belongs_to :work_process
end
