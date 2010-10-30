module Fileshare
  class Base
    attr_accessor :bucket

    def initialize(existing_bucket = nil)
      Rails.logger.debug "[FILESHARE] Connecting to S3..."
      AWS::S3::Base.establish_connection!(
        :access_key_id     => ENV['S3_KEY'],
        :secret_access_key => ENV['S3_SECRET']
      )

      if existing_bucket
        Rails.logger.debug "[FILESHARE] Opening existing bucket #{existing_bucket}..."
        self.bucket = AWS::S3::Bucket.find(existing_bucket)
      elsif !create_bucket
        raise "Could not create S3 bucket!"
      end
    end

    def folders
      return @folders if @folders

      @folders = Folder.new('Filbibliotek')
      self.bucket.objects.each { |o| @folders << o.key.split('/') }
      @folders
    end

    def files(path)
      # make sure the path ends with a /
      path += '/' if path !~ /\/$/
      Rails.logger.debug "--> #{path.inspect}"

      # get all keys under the given path
      keys = self.bucket.objects(:prefix => path).map(&:key)
      Rails.logger.debug "--> #{keys.inspect}"

      # trim away the pre-path, so the base is the current directory
      keys.map! { |k| k.gsub(/^#{path.gsub('/', '\/')}/, '') }
      Rails.logger.debug "--> #{keys.inspect}"

      # ignore sub-directories
      keys.reject! { |k| k =~ /\// }
      Rails.logger.debug "--> #{keys.inspect}"
      keys.reject! { |k| k =~ /_\$folder\$$/ }
      Rails.logger.debug "--> #{keys.inspect}"

      keys.map { |k| { :name => k } }
    end

    private

    def create_bucket(retry_count = 10)
      retry_count.times do
        bucket = Digest::MD5.hexdigest(Time.now.to_s)
        Rails.logger.debug "[FILESHARE] Creating new S3 bucket named #{bucket}..."

        begin
          if AWS::S3::Bucket.create(bucket)
            self.bucket = AWS::S3::Bucket.find(bucket)
            return bucket
          else
            Rails.logger.error "[FILESHARE] Could not create S3 bucket #{bucket}"
            return
          end
        rescue AWS::S3::ResponseError => e
          Rails.logger.debug "[FILESHARE] Captured S3 exception: #{e.response.inspect}"
          if e.response.error.code != 'BucketAlreadyExists'
            Rails.logger.error "[FILESHARE] Could not create S3 bucket #{bucket} (error: #{e.response.inspect})"
            return
          end
        end
      end
    end
  end
end
