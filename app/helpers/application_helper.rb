module ApplicationHelper

  def current_lang
    I18n.locale
  end

  def ogp_locale_tags
    out = tag :meta, property: 'og:locale', content: current_lang

    I18n.available_locales.reject { |e| e == current_lang }.each do |lang|
      out += tag :meta, property: 'og:locale:alternate', content: lang
    end

    out
  end

end
