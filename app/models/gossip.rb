class Gossip < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :tag_gossip_links
  has_many :tags, through: :tag_gossip_links
  validates :title, presence: true, length: { in: 3..14 }
  validates :content, presence: true
end
