module Fileshare
  class Files < Array
    def to_json
      map { |name| { :name => name } }
    end
  end
end
