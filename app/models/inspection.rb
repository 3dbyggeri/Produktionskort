# coding: utf-8
class Inspection < ActiveRecord::Base
  KINDS = %w[Startkontrol Processkontrol Slutkontrol Modtagekontrol]
  METHODS = %w[Visuel Lod Mål]
  belongs_to :work_process
  has_many :documentations

  accepts_nested_attributes_for :documentations, :allow_destroy => true
end
