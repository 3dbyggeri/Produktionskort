# coding: utf-8
class SiteFocus < ActiveRecord::Base
  belongs_to :project

  KINDS = ["Belysning","Kabler, tavler og ledninger","Oplagsplads","Værksteder/præfabrikationspladser","Blandeplads","Kraner og anhugningsgrej","Stillads","Stiger","Arbejdsplatform/lift","Afspærringer og afdækninger","Udgravninger","Oprydning og rengøring","Mobilarbejdsplads"]
end
