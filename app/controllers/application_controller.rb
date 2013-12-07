class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale

  private

    def set_locale
      @available_locales ||= I18n.available_locales.map { |e| e.to_s.gsub('_', '-') }
      use_locale = override_language || session[:current_locale] || ((tmp = http_accept_language.compatible_language_from(@available_locales)) ? tmp.gsub('-', '_').to_sym : nil) || I18n.default_locale

      I18n.locale = use_locale
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
        ja: :ja_JP,
        ja_jp: :ja_JP,
        en: :en_US,
        en_us: :en_US
      }[input.to_sym] || input.to_sym
    end

end
