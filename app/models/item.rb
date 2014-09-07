class Item < ActiveRecord::Base
  belongs_to :feed

  paginates_per 30
end
