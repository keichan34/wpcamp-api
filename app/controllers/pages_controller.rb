class PagesController < ApplicationController

  def index
    @preload_up_to_page = params[:page] || 1
  end

end
