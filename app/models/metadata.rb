class Metadata < ActiveRecord::Base

  def self.[] key
    self.where( key: key ).first.try :value
  end

  def self.[]= key, value
    tmp = self.where( key: key ).first_or_initialize
    tmp.value = value
    tmp.save!
  end

end
