class FeedsController < ApplicationController
  def index
    @feeds = Feed.all  #controllarにわたされる
  end

  def new
    @feed = Feed.new
  end

  def create
    @feed = Feed.new(params[:feed])
    
    if @feed.save
      redirect_to feeds_path  #saveが成功したらindexへ
    else
      render :new  #失敗したらnew入力へ
    end
  end

  def show
  end

  def edit
    @feed = Feed.find(params[:id])
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
# destroy
end
