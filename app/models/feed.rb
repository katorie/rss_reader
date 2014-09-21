class Feed < ActiveRecord::Base
  before_save :get_rss

  has_many :items, dependent: :destroy  

  def update_items!
    feed = Feedjira::Feed.fetch_and_parse(self.url)

    feed.entries.each do |entry|
      unless items.where(url: entry.url).exists?
        items.create!({body: entry.content, title: entry.title, url: entry.url, posted_at: entry.published})
        logger.info "created! #{{body: entry.content, title: entry.title, url: entry.url, posted_at: entry.published}.inspect}"
      end
    end
  end

  private

  def get_rss
    feed = Feedjira::Feed.fetch_and_parse(self.url)
    
    feed.entries.each do |entry|
      self.items.build({body: entry.content, title: entry.title, url: entry.url, posted_at: entry.published})
      # create はnew（初期化）とsave（保存）を同時にしてくれる
      # buildではなくcreateでやりかけたけど、修正
    end

    self.title = feed.title
  end
end
