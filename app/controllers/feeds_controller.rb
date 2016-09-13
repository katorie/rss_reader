class FeedsController < ApplicationController
  before_action :accessible_check, :except => [:index, :show]

  def index
    last_updated_times = Item.group(:feed_id).maximum(:updated_at)

    @feeds = Feed.all.order(:author).map { |feed|
      { id:         feed.id,
        title:      feed.title,
        author:     feed.author,
        posted_at:  last_updated_times[feed.id]
      }
    }
    feed_ids = params[:id] ? params[:id] : @feeds.map {|f| f[:id]}
    @items = Item.includes(:feed).where(feeds: {id: feed_ids}).order('posted_at desc').page(params[:page])
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
    @feed.attributes = feed_params

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
