class AddPaperclipToApproval < ActiveRecord::Migration
  def self.up
    add_column :approvals, :attachment_file_name, :string
    add_column :approvals, :attachment_content_type, :string
    add_column :approvals, :attachment_file_size, :integer
    add_column :approvals, :attachment_updated_at, :datetime
  end

  def self.down
    remove_column :approvals, :attachment_updated_at
    remove_column :approvals, :attachment_file_size
    remove_column :approvals, :attachment_content_type
    remove_column :approvals, :attachment_file_name
  end
end
