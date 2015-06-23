class CreateUserFieldOptions < ActiveRecord::Migration
  def change
    create_table :user_field_options do |t|
      t.string :value

      t.timestamps null: false
    end
  end
end
