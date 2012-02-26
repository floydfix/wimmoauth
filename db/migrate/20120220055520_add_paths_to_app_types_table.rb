class AddPathsToAppTypesTable < ActiveRecord::Migration
  def self.up
    add_column :app_types, :oauth_path, :string
    add_column :app_types, :params, :string
    add_column :app_types, :params_end, :string
  end
  
  def self.down
    remove_column :app_types, :oauth_path
    remove_column :app_types, :params
    remove_column :app_types, :params_end
  end
end
