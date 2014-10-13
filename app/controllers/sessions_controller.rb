class SessionsController < Devise::SessionsController

  before_filter :get_feeds

  def new
    super
  end

  def create
    super
  end

  private
  def get_feeds
    @feeds = Feed.all
    @items = Item.includes(:feed).order('posted_at desc').page(params[:page])
  end

end
