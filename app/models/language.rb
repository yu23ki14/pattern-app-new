class Language < ApplicationRecord
  has_many :patterns
  has_many :practices
  has_many :favorites
  has_many :excharts
  
  def lg_name
    self.send("lg_name_#{I18n.locale}")
  end
end
