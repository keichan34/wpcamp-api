class V1::WordcampsController < ApplicationController

  def index
    @wordcamps = WordCamp.order('start DESC').page params[:page]

    default_response
  end

  def show
    @wordcamp = WordCamp.find params[:id]

    default_response
  end

  def search
    @wordcamps = WordCamp.basic_search({ title: params[:q], description: params[:q] }, false).page params[:page]

    default_response do
      render 'index'
    end
  end

  def location
    @wordcamps = WordCamp.where( title_for_slug: params[:location] ).order('start DESC').page params[:page]

    if params[:include_banners]
      @wordcamps = @wordcamps.includes :banners
      @include_banners = true
    end

    if params[:year]
      @wordcamps = @wordcamps.where( 'EXTRACT(YEAR FROM "start") = ?', params[:year] )
    end

    default_response do
      render 'index'
    end
  end

  private

    def default_response
      respond_to do |f|
        f.html { redirect_to root_path }
        if block_given?
          f.json { yield }
        else
          f.json
        end
      end
    end

end
