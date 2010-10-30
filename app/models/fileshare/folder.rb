module Fileshare
  class Folder
    attr_reader :name

    def initialize(name, sub_segments = [])
      @name = name
      @folders = {}
      @files = {}

      if sub_segments.size == 1
        filename = sub_segments.shift
        @files = { filename => Fileshare::File.new(filename) }
      elsif sub_segments.size > 1
        foldername = sub_segments.shift
        @folders = { foldername => Folder.new(foldername, sub_segments) }
      end
    end

    def <<(sub_segments)
      if sub_segments.size == 1 && sub_segments.first !~ /_\$folder\$$/ # defacto S3 standard: keys ending ind _$folder$ is folders
        add_file(sub_segments.shift)
      else
        add_folder(sub_segments)
      end
    end

    def add_file(name)
      raise "Can't add the same file twice!" if @files.has_key? name
      @files[name] = Fileshare::File.new(name)
    end

    def add_folder(sub_segments)
      name = sub_segments.shift.gsub(/_\$folder\$$/, '') # defacto S3 standard: keys ending ind _$folder$ is folders
      if @folders.has_key?(name) && !sub_segments.empty?
        @folders[name] << sub_segments
      elsif !@folders.has_key?(name)
        @folders[name] = Folder.new(name, sub_segments)
      end
    end

    def filenames
      @files.values.map(&:name)
    end

    def to_json(open = false)
      {
        :data => {
          :title => @name,
          :attr => { :class => 'tree-node' }
        },
        :state => (open ? 'open' : 'closed'),
        :children => @folders.values.map(&:to_json)
      }
    end
  end
end