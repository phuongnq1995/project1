class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @activity = current_user.feed.paginate page: params[:page], per_page: 15
    else
      @activity = Activity.all.paginate page: params[:page], per_page: 15
    end
  end
end
