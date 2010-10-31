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

    def folders(path = '')
      Rails.logger.debug "[FILESHARE] Loading sub-folders for #{path}"
      Folders.new folder(path).select { |k| k =~ /_\$folder\$$/ }.map { |k| k.sub(/_\$folder\$$/, '') }
    end

    def files(path = '')
      Rails.logger.debug "[FILESHARE] Loading files in #{path}"
      Files.new folder(path).select { |k| k !~ /_\$folder\$$/ }
    end

    def file(key)
      filename = key.split('/').last
      objects = self.bucket.objects(:prefix => key)
      raise "Could not find attachment #{key}!" if objects.empty?
      raise "Search for #{key} produced ambiguous result!" if objects.size > 1

      Rails.logger.debug "[FILESHARE] Importing attachment #{objects.first.key}"

      attachment = StringIO.new objects.first.value
      attachment.instance_eval <<-RUBY
        def original_filename
          '#{filename}'
        end
      RUBY

      return attachment
    end

    private

    def folder(path)
      # make sure the path ends with a /
      path += '/' if !path.blank? && path !~ /\/$/

      # only the keys that matches the path
      keys = self.bucket.objects(:prefix => path).map(&:key)
      # remove the base of the key
      keys.map! { |k| k.sub(/^#{path.gsub('/', '\/')}/, '') }
      # ignore sub-folders
      keys.select { |k| k !~ /\// }
    end

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
