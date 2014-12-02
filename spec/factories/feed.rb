FactoryGirl.define do
  factory :feed do
    title    'test_feed_title'
    feed_url 'http://railsguides.net/'
    url      'http://railsguides.net/atom.xml'
    author   'alice'
  end
end
