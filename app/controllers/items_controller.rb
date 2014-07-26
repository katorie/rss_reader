class ItemsController < ApplicationController
  def show
    @feeds = Feed.all
    @item = Item.find(params[:id])
  end

end
