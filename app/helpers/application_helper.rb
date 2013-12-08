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

  def error_description_list errors, key
    return '' if errors.empty?

    errors[key].map do |x|
      content_tag :span, class: 'help-block' do
        errors.full_message key, x
      end
    end.join('').html_safe
  end

end
