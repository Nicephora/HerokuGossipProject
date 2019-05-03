class CreateTagGossipLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_gossip_links do |t|
      t.belongs_to :gossip, index: true
      t.belongs_to :tag, index: true
      t.timestamps
    end
  end
end
