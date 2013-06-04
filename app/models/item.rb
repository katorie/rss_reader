class Item < ActiveRecord::Base
  attr_accessible :body, :feed_id, :title, :url
end
