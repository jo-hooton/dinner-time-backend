class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :cook_minutes, :prep_minutes, :rating, :image, :ingredients

  def ingredients
    object.ingredients.pluck(:name)
  end
end