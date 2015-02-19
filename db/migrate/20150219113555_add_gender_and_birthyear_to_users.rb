class AddGenderAndBirthyearToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gender, :string
    add_column :users, :birthyear, :integer
  end
end
