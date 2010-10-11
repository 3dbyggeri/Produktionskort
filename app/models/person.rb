# coding: utf-8
class Person < ActiveRecord::Base
  belongs_to :project
  belongs_to :company
  
  KINDS = ["Byggeleder", "Formand", "Projektleder", "Teknisk assistent",
           "Sikkerhedskoordinator", "Sikkerhedsrepræsentant", "Pladsmand",
           "Vagt"]
end
