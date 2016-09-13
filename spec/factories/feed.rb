FactoryGirl.define do
  factory :feed do
    title    'test_feed_title'
    feed_url FFaker::Internet.http_url + '/blog/rss'
    url      FFaker::Internet.http_url
    author   'alice'

    to_create do |instance|
      instance.save validate: false
    end
  end
end
