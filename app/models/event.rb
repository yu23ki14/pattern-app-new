class Event < ApplicationRecord
  belongs_to :user
  has_many :excharts
  
  validates :event_code,
    presence: true,
    format: { with: /\A[a-z0-9]+\z/i },
    uniqueness: true
  validates :event_code,
    presence: true
end
