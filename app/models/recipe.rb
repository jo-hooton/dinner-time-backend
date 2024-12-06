class Recipe < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_ingredients,
    against: [:ingredients],
    using: {
      tsearch: { prefix: true }
    }

  validates :title, presence: true
end
