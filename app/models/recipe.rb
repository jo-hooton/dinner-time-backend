class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy

  validates :title, presence: true
end
