class CreateArgumentTypes < ActiveRecord::Migration
  def change
    create_table :argument_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
