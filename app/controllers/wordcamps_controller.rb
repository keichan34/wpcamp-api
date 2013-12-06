class WordcampsController < ApplicationController

  def index
    @wordcamps = WordCamp.order('start DESC').page params[:page]

    respond_to do |f|
      f.html { redirect_to root_path }
      f.json
    end
  end

  def show
    @wordcamp = WordCamp.find params[:id]

    respond_to do |f|
      f.html { redirect_to root_path }
      f.json
    end
  end

end
