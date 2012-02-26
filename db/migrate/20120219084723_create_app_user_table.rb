class CreateAppUserTable < ActiveRecord::Migration
  def up
    create_table :app_users do |t|
      t.integer :app_id
      t.string  :user_id
      t.string  :user_name
      t.string  :token
      t.string  :code
      t.integer :code_expire
      t.boolean :code_reset
      t.timestamps
    end
    
    add_index :app_users, [:app_id, :user_id], :unique => true
  end

  def down
    drop_table :app_users
  end
end
