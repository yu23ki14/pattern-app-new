class Language < ApplicationRecord
  has_many :patterns
  has_many :practices
  has_many :favorites
  has_many :excharts
end
