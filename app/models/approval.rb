# coding: utf-8
class Approval < ActiveRecord::Base
  belongs_to :project

  KINDS = ['Byggetilladelse', 'Geoteknisk rapport', 'Statiske beregninger', 'Miljøgodkendelse']
end
