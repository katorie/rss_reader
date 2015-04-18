FactoryGirl.define do
  factory :feed do
    title    'test_feed_title'
    feed_url FFaker::Internet.http_url
    url      FFaker::Internet.http_url + '/atom.xml'
    author   'alice'

    to_create do |instance|
      instance.save validate: false
    end
  end
end
