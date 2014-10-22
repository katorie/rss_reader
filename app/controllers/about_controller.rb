class AboutController < ApplicationController
  def index
    @feeds = Feed.all
  end
end
