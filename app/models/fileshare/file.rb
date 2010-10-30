module Fileshare
  class File
    attr_reader :name
    def initialize(name)
      @name = name
    end
  end
end