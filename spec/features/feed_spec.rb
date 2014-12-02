require 'spec_helper'

feature 'feed 一覧' do
  let!(:feed) { FactoryGirl.create :feed, author: 'alice' }

  scenario 'feed の持ち主の名前が表示されること' do
    visit root_path 
    within first('.panel-title') do
      expect(page).to have_content 'alice'
    end
  end
end
