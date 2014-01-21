class ChangeContentTypeInArguments < ActiveRecord::Migration
  def self.up
    change_column :arguments, :content, :text
  end
 
  def self.down
    change_column :arguments, :content, :string
  end
end
