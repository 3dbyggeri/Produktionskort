class AddFileshareBucketToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :fileshare_bucket, :string
    Project.all.each do |project|
      project.update_attribute(:fileshare_bucket, project.fileshare.bucket.name)
    end
  end

  def self.down
    remove_column :projects, :fileshare_bucket
  end
end
