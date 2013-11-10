class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstName
      t.string :surname
      t.string :email
      t.string :password_diggest

      t.timestamps
    end
  end
end
