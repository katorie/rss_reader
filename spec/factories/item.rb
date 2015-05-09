FactoryGirl.define do
  factory :item do
    feed
    title     'blog title'
    body      'blog body'
    url       FFaker::Internet.http_url
    posted_at Time.now
  end
end
