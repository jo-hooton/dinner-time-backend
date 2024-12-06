class Recipe < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_title_and_ingredients,
    against: [:title],
    using: {
      tsearch: { prefix: true }
    }

  validates :title, presence: true
end
