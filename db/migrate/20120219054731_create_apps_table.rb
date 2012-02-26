class CreateAppsTable < ActiveRecord::Migration
  def up
    create_table :apps do |t|
      t.integer :user_id
      t.string  :app_name
      t.integer :app_type
      t.string  :app_key
      t.string  :ext_app_key
      t.string  :ext_app_secret
      t.timestamps
    end
    create_table :app_types do |t|
      t.string  :description
    end
    
    add_index :apps, [:user_id, :ext_app_key, :ext_app_secret], :unique => true
  end

  def down
    drop_table :apps
    drop_table :app_types
  end
end
