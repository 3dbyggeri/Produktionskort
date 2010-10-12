class AddExtraAttachmentOptions < ActiveRecord::Migration
  def self.up
    add_column :approvals, :attachment_origin, :integer
    add_column :approvals, :attachment_origin_id, :string
    add_column :referrals, :attachment_origin, :integer
    add_column :referrals, :attachment_origin_id, :string
  end

  def self.down
    remove_column :approvals, :attachment_origin
    remove_column :approvals, :attachment_origin_id
    remove_column :referrals, :attachment_origin
    remove_column :referrals, :attachment_origin_id
  end
end
