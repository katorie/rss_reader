require 'spec_helper'

RSpec.describe FeedsController, type: :controller do
  describe "GET index" do
    let(:feed_a) { FactoryGirl.create(:feed) }
    let(:feed_b) { FactoryGirl.create(:feed) }
    let!(:item_a) { FactoryGirl.create(:item, feed: feed_a) }
    let!(:item_b) { FactoryGirl.create(:item, feed: feed_b) }

    context 'no filter' do
      before(:each) { get :index }
      it { expect(assigns(:items)).to match_array([item_a, item_b]) }
    end

    context 'filtered by feed' do
      before(:each) { get :index, id: feed_a.id }
      it { expect(assigns(:items)).to match_array([item_a]) }
    end
  end
end
