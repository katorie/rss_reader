require 'spec_helper'

describe Feed, type: :model do

  it { should have_many(:items).dependent(:destroy) }
  it { should validate_presence_of :url }
  it { should validate_uniqueness_of :url }

  describe '#get_rss' do
    context '他のvalidationエラーがあるとき' do
      it '#get_rss は呼ばれない' do
        feed = Feed.new( url: '' )
        expect(Feedjira::Feed).to_not receive(:fetch_and_parse)
        expect(feed).to be_invalid
        expect(feed.errors[:base]).to be_empty
      end
    end
    context '他のvalidationエラーがないとき' do
      it '#get_rss が呼ばれる' do
        feed = Feed.new( url: 'http://example.com/blog' )
        expect(Feedjira::Feed).to receive(:fetch_and_parse).and_return(0)
        expect(feed).to be_invalid
        expect(feed.errors[:base]).to be_present
      end
    end
  end

  describe '#update_items!' do

    # Build feed to be tested.
    let(:feed) do
      Feed.new(
        title: 'The blog',
        url: 'http://example.com/blog',
        feed_url: 'http://example.com/blog/rss',
        etag: '686897696a7c876b7e',
        last_modified: 1.week.ago
      )
    end

    # Assign `published`. This will be explained in assertion.
    let(:published) { 1.hour.ago }

    before do
      # Use #allow to set fake behavior to an object.
      # By this, the feed will receive #get_rss and returns nothing.
      # See :https://www.relishapp.com/rspec/rspec-mocks/v/3-0/docs/basics/allowing-messages
      allow(feed).to receive(:get_rss)

      # Save the feed. #get_rss is stubbed so it won't send HTTP request to the feed.
      feed.save!
    end

    context 'entryがcontentを含むとき' do
      it 'should add items from feed' do
        # Stub `Feedjira::Feed` and return fake response.
        allow(Feedjira::Feed).to receive(:fetch_and_parse) {
          # Create entries. OpenStruct is a Hash-like object which allows ActiveRecord::Base
          # like attribute accessor.
          # See: http://www.ruby-doc.org/stdlib-2.1.2/libdoc/ostruct/rdoc/OpenStruct.html
          entries = [
            OpenStruct.new(
              content: 'hello',
              title: 'This is title',
              url: 'http://example.com/blog/1',
              published: published
            )
          ]
          # Return fake object which can receive #entries and return entries we made.
          # This kind of fake object is called 'test double'.
          # See: https://www.relishapp.com/rspec/rspec-mocks/v/3-0/docs/basics/test-doubles
          double(entries: entries)
        }

        # Do what we're testing.
        feed.update_items!
        # Assert expected behavior: One item will be made for the feed and it should
        # have values in the entry.
        expect(feed.items.first.body).to eq "hello"
        expect(feed.items.first.title).to eq "This is title"
        expect(feed.items.first.url).to eq "http://example.com/blog/1"
        expect(feed.items.first.posted_at.to_i).to eq published.to_i
      end
    end

    context 'entryがcontentを含まないがsummaryを含むとき' do
      it 'should add items from feed and has content in body' do
        allow(Feedjira::Feed).to receive(:fetch_and_parse) {
          entries = [
            OpenStruct.new(
              summary: 'hello',
              title: 'This is title',
              url: 'http://example.com/blog/1',
              published: published
            )
          ]
          double(entries: entries)
        }
        feed.update_items!

        # Assert expected behavior: One item will be made for the feed and it should
        # have values in the entry.
        expect(feed.items.first.body).to eq "hello"
        expect(feed.items.first.title).to eq "This is title"
        expect(feed.items.first.url).to eq "http://example.com/blog/1"
        expect(feed.items.first.posted_at.to_i).to eq published.to_i
      end
    end
  end
end
