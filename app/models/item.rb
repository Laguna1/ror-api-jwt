class Item < ApplicationRecord
  belongs_to :user
  validates :day, presence: true, uniqueness: true

  has_many :tracks, dependent: :destroy
end
