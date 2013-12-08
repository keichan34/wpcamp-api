class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale

  private

    def set_locale
      use_locale = override_language || session[:current_locale] || http_accept_language.compatible_language_from(I18n.available_locales) || I18n.default_locale

      begin
        I18n.locale = use_locale
      rescue I18n::InvalidLocale => e
        I18n.locale = use_locale = :en
      end

      @locale = I18n.locale

      if session[:current_locale] != use_locale
        session[:current_locale] = use_locale
      end
    end

    def override_language
      override_to = normalize_language_code (request.headers['X-Facebook-Locale'] || params[:locale])
      return nil unless override_to
      I18n.locale_available?(override_to) ? override_to : nil
    end

    def normalize_language_code input
      return nil if !input
      {
        ja_jp: :ja,
        ja_JP: :ja,
        en_US: :en,
        en_us: :en
      }[input.to_sym] || input.to_sym
    end

end
