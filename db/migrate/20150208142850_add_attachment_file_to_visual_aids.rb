class AddAttachmentFileToVisualAids < ActiveRecord::Migration
  def self.up
    change_table :visual_aids do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :visual_aids, :file
  end
end
