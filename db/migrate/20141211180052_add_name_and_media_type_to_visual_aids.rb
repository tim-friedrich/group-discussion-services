class AddNameAndMediaTypeToVisualAids < ActiveRecord::Migration
  def change
    add_column :visual_aids, :name, :string
    add_column :visual_aids, :media_type, :string
  end
end
