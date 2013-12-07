class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale

  private

    def set_locale
      session[:current_locale] = override_language || session[:current_locale] || http_accept_language.compatible_language_from(I18n.available_locales)
      I18n.locale = session[:current_locale]
    end

    def override_language

      override_to = normalize_language_code (params[:fb_locale] || params[:locale])
      return nil unless override_to
      I18n.locale_available?(override_to) ? override_to : nil
    end

    def normalize_language_code input
      {
        ja: :ja_JP,
        ja_jp: :ja_JP,
        en: :en_US,
        en_us: :en_US
      }[input.to_sym] || input.to_sym
    end

end
