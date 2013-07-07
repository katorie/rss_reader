class Feed < ActiveRecord::Base
  attr_accessible :etag, :feed_url, :last_modified, :title, :url

  before_save :get_rss

  has_many :items, dependent: :destroy  

  private

  def get_rss
    feed = Feedzirra::Feed.fetch_and_parse(self.url)
    
    feed.entries.each do |entry|
      self.items.build({body: entry.content, title: entry.title, url: entry.url})
      # create はnew（初期化）とsave（保存）を同時にしてくれる
    end

    self.title = feed.title
  end
end
