class RenameProjectFileshareBucketToFilesharePrefix < ActiveRecord::Migration
  def self.up
    rename_column :projects, :fileshare_bucket, :fileshare_prefix
  end

  def self.down
    rename_column :projects, :fileshare_prefix, :fileshare_bucket
  end
end
