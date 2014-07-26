class ItemsController < ApplicationController
  def show
    @items = Item.all
    @item = Item.find(params[:id])
  end

end
