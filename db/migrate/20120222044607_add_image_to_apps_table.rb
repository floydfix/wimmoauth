class AddImageToAppsTable < ActiveRecord::Migration
  def self.up
    add_column :apps, :image, :binary
  end
  
  def self.down
    remove_column :apps, :image
  end
end
