class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to dashboard_url
    else
      render :layout => false
    end
  end

end
