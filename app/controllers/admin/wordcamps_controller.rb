class Admin::WordcampsController < AdminController

  def index
    @wordcamps = WordCamp.order('start DESC').page params[:page]
  end

  def show
    @wordcamp = WordCamp.find params[:id]
  end

  def location
    @wordcamps = WordCamp.where( title_for_slug: params[:location] ).order('start DESC').page params[:page]

    render 'index'
  end

  private

    def wordcamp_params
      params.require(:wordcamp).permit :title, :description
    end

end
