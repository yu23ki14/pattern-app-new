class Language < ApplicationRecord
  has_many :patterns
  has_many :practices
  has_many :favorites
end
