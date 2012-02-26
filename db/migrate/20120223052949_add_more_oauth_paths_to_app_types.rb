class AddMoreOauthPathsToAppTypes < ActiveRecord::Migration
  def self.up
    add_column :app_types, :oauth_path_2, :string
    add_column :app_types, :oauth_path_3, :string

    add_column :app_types, :params_2, :string
    add_column :app_types, :params_3, :string

    add_column :app_types, :params_end_2, :string
    add_column :app_types, :params_end_3, :string
  end
  
  def self.down
    remove_column :app_types, :oauth_path_2
    remove_column :app_types, :oauth_path_3
    
    remove_column :app_types, :params_2
    remove_column :app_types, :params_3

    remove_column :app_types, :params_end_2
    remove_column :app_types, :params_end_3

  end
end
