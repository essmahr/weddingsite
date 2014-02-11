class Items < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :item_id
    end
  end
  
  def self.down
    drop_table :posts
  end
  
end
