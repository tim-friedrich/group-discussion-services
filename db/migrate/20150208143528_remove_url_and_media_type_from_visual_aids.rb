class RemoveUrlAndMediaTypeFromVisualAids < ActiveRecord::Migration
  def change
    remove_column :visual_aids, :media_type, :string
    remove_column :visual_aids, :url, :string
  end
end
