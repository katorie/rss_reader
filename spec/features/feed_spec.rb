require 'spec_helper'

feature 'Feed 一覧を表示する' do
  let!(:feed) { FactoryGirl.create :feed, author: 'alice' }

  scenario 'feed の持ち主の名前が表示されること' do
    visit root_path
    within first('.panel-title') do
      expect(page).to have_content 'alice'
    end
  end
end

feature 'Feed 詳細画面を表示する' do
  let!(:feed) { FactoryGirl.create :feed, author: 'alice' }

  scenario 'feed の持ち主の名前が表示されること' do
    visit feed_path(feed)
    within 'h2' do
      expect(page).to have_content 'alice'
    end
  end
end
