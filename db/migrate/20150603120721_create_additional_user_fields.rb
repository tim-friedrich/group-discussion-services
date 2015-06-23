class CreateAdditionalUserFields < ActiveRecord::Migration
  def change
    create_table :additional_user_fields do |t|
      t.string :name
      t.string :type
      
      t.timestamps null: false
    end
  end
end
