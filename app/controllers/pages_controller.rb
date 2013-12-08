class PagesController < ApplicationController

  def index
  end

  def redirect_to_current_locale
    redirect_to root_with_locale_path(locale: session[:current_locale])
  end

  def index_page
    to_fetch = Kaminari.config.default_per_page * params[:page].to_i
    @wordcamps = WordCamp.order('start DESC').limit to_fetch

    render 'index'
  end

end
