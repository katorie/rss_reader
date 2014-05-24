class Item < ActiveRecord::Base
  attr_accessible :body, :feed_id, :title, :url, :posted_at

  belongs_to :feed
end
