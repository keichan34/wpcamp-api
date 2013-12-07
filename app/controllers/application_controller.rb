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
      return nil unless params[:locale]
      I18n.locale_available?(params[:locale].to_sym) ? params[:locale].to_sym : nil
    end

end
