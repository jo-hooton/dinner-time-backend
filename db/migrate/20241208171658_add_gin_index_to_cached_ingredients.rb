class AddGinIndexToCachedIngredients < ActiveRecord::Migration[8.0]
  def change
    enable_extension "pg_trgm" unless extension_enabled?("pg_trgm")

    add_index :recipes, :cached_ingredients, using: :gin, opclass: :gin_trgm_ops
  end
end
