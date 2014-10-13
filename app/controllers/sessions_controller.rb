class SessionsController < Devise::SessionsController

  def new
    @feeds = Feed.all
    @items = Item.includes(:feed).order('posted_at desc').page(params[:page])
    super
  end

  def create
    @feeds = Feed.all
    @items = Item.includes(:feed).order('posted_at desc').page(params[:page])
    super
  end

end
