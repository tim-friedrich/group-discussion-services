class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.float :n
      t.float :e
      t.float :c
      t.float :a
      t.float :o
      t.float :lm
      t.float :mm
      t.float :sm
      t.float :x

      t.timestamps null: false
    end
  end
end
