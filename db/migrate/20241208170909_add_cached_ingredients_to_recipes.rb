class AddCachedIngredientsToRecipes < ActiveRecord::Migration[8.0]
  def change
    add_column :recipes, :cached_ingredients, :text
  end
end
