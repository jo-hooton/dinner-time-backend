class Recipe < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_cached_ingredients,
                  against: :cached_ingredients,
                  using: {
                    tsearch: { prefix: true }
                  }

  has_many :ingredients, dependent: :destroy

  # update cached ingredients after ingredients are modified
  after_save :update_cached_ingredients

  private

  def update_cached_ingredients
    self.cached_ingredients = ingredients.pluck(:name).join(", ")
    save if cached_ingredients_changed?
  end
end
