class RecipesController < ApplicationController
  def index
    recipes_query = Recipe

    # Add conditions for included ingredients
    if params[:query].present?
      recipes_query.search_by_cached_ingredients(params[:query])
    end

    # Add conditions for excluded ingredients
    if params[:exclude].present?
      exclude_ingredients = params[:exclude].split
      recipes_query = recipes_query.where.not(
        exclude_ingredients.map { "cached_ingredients ILIKE ?" }.join(" OR "),
        *exclude_ingredients.map { |i| "%#{i}%" }
      )
    end

    # Add conditions for time constraints
    if params[:time].present?
      recipes_query = recipes_query.where("cook_minutes + prep_minutes <= ?", params[:time].to_i)
    end

    # Add pagination
    recipes_query = recipes_query.page(params[:page]).per(params[:per] || 10)

    # Fetch and render the recipes as JSON
    render json: recipes_query, each_serializer: RecipeSerializer
  end
end
