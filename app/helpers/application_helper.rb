module ApplicationHelper

  def current_lang
    I18n.locale
  end

  def ogp_locale_tags
    # Prepare the locales for OGP
    trans = {
      ja: :ja_JP,
      en: :en_US
    }

    out = tag :meta, property: 'og:locale', content: trans[current_lang]

    I18n.available_locales.reject { |e| e == current_lang }.each do |lang|
      out += tag :meta, property: 'og:locale:alternate', content: trans[lang]
    end

    out
  end

end
