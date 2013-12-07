class PagesController < ApplicationController

  def index
  end

  def index_page
    to_fetch = Kaminari.config.default_per_page * params[:page].to_i
    @wordcamps = WordCamp.order('start DESC').limit to_fetch

    render 'index'
  end

end
