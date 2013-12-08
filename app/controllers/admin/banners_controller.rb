class Admin::BannersController < AdminController

  before_filter :set_wordcamp

  def index
    @banners = scope_for_params.load
  end

  def show
    @banner = scope_for_params.first!
  end

  def edit
    @banner = scope_for_params.first!
  end

  def new
    @banner = Banner.new
    @banner.word_camp = @wordcamp
  end

  def create
    @banner = Banner.new banner_params
    @banner.word_camp = @wordcamp

    if @banner.valid? and @banner.save
      redirect_to admin_word_camp_banner_path(id: @banner.id, word_camp_id: @wordcamp.id), notice: 'The banner was successfully created.'
    else
      render 'edit', alert: 'The banner could not be saved due to errors.'
    end
  end

  def update
    @banner = scope_for_params.first!

    if @banner.update banner_params
      redirect_to admin_word_camp_banner_path(id: @banner.id, word_camp_id: @banner.word_camp.id), notice: 'The banner was successfully updated.'
    else
      render 'edit', alert: 'The banner could not be updated due to errors.'
    end
  end

  def destroy
    @banner = scope_for_params.first!

    if @banner.destroy
      redirect_to admin_word_camp_banners_path(word_camp_id: @banner.word_camp.id), notice: 'The banner was successfully deleted.'
    else
      redirect_to admin_word_camp_banner_path(id: @banner.id, word_camp_id: @banner.word_camp.id), notice: 'The banner could not be deleted.'
    end
  end

  private

    def scope_for_params
      opts = { word_camp_id: params[:word_camp_id] }
      opts[:id] = params[:id] if params[:id]
      Banner.where( opts )
    end

    def banner_params
      params.require(:banner).permit :title, :alt, :width, :height, :banner, :delete_banner
    end

    def set_wordcamp
      @wordcamp = WordCamp.find params[:word_camp_id]
    end

end
