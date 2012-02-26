class AddGetUserPathToAppTypes < ActiveRecord::Migration
  def self.up
    add_column :app_types, :get_user_path, :string
  end
  
  def self.down
    remove_column :app_types, :get_user_path
  end
end
