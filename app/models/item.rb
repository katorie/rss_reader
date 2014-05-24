class Item < ActiveRecord::Base
  attr_accessible :body, :feed_id, :title, :url

  belongs_to :feed
end
