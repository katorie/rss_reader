class Feed < ActiveRecord::Base
  after_validation :get_rss, if: ->(feed){ feed.errors.empty? }

  has_many :items, dependent: :destroy

  validates :url, presence: true, uniqueness: true

  def update_items!
    feed = Feedjira::Feed.fetch_and_parse(self.url)

    return failed_fetch_feed unless feed.respond_to?(:entries)

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

    return failed_fetch_feed unless feed.respond_to?(:entries)

    feed.entries.each do |entry|
      self.items.build({body: entry.content, title: entry.title, url: entry.url, posted_at: entry.published})
      # create はnew（初期化）とsave（保存）を同時にしてくれる
      # buildではなくcreateでやりかけたけど、修正
    end

    self.title = feed.title
  end

  def failed_fetch_feed
    logger.error "failed fetch feed: #{self.url}"
    errors.add(:base, I18n.t('errors.messages.failed_fetch_feed'))
  end
end
