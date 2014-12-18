class FeedsController < ApplicationController
  before_filter :accessible_check, :except => [:index, :show]

  def index
    @feeds = Feed.all
    @items = Item.includes(:feed).order('posted_at desc').page(params[:page])
  end

  def new
    @feed = Feed.new
    @feeds = Feed.all
  end

  def create
    @feed = Feed.new(feed_params)

    if @feed.save
      redirect_to feeds_path
    else
      @feeds = Feed.all
      render :new
    end
  end

  def show
    @feed = Feed.find(params[:id])
    @items = @feed.items
    @feeds = Feed.all
  end

  def edit
    @feed = Feed.find(params[:id])
    @feeds = Feed.all
  end

  def update
    @feed = Feed.find(params[:id]) 
    @feed.attributes = params[:feed]

    if @feed.save
      redirect_to feeds_path
    else
      render :edit
    end
  end

  def destroy
    @feed = Feed.destroy(params[:id])
    redirect_to feeds_path
  end

  private

  def feed_params
    params.require(:feed).permit(
      :body, :title, :url, :author, :posted_at
    )
  end

  def accessible_check
    raise unless user_signed_in?
  end

end
