class Pattern < ApplicationRecord
  belongs_to :language
  has_many :clips
  has_many :users, through: :clips
end
