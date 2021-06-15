class Item < ApplicationRecord
  belongs_to :user
  validates :day, presence: true, uniqueness: true

end
