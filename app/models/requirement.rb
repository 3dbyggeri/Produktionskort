# coding: utf-8
class Requirement < ActiveRecord::Base
  KINDS = %w[Udfald Funktion Finish Holdbarhed Miljø]
  belongs_to :work_process
end
