# coding: utf-8
class Protection < ActiveRecord::Base
  KINDS = ["Hjelm","Høreværn","Sikkerhedsbriller","Sikkerhedssko","Handsker","Knæbeskytter","Beklædning","Forklæde","Skærebukser","Støvdragter/engangsdragt","Regntøj","Termodragt","Syrefast tøj","Faldseler","Åndedrætsværn"]
  belongs_to :work_process
end