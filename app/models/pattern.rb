class Pattern < ApplicationRecord
  belongs_to :language
  has_many :favorites
  has_many :practices
end
