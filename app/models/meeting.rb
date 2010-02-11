class Meeting < ActiveRecord::Base
  belongs_to :project
  
  KINDS = %w[Projektmøde Opstartsmøde Byggemøde Formandsmøde Sikkerhedsmøde]
end
