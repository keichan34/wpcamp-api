module HasGuid
  extend ActiveSupport::Concern

  included do
    before_create :generate_guid
  end

  def reset_guid!
    generate_guid
    save!
  end

  protected

    def generate_guid
      self.guid = loop do
        random_guid = SecureRandom.urlsafe_base64(nil, false)
        break random_guid unless self.class.exists?(guid: random_guid)
      end
    end

end
