class RecipesController < ApplicationController
  def index
    recipes_query = Recipe

    # Add conditions for included ingredients
    if params[:query].present?
      query_ingredients = params[:query].split
      recipes_query = recipes_query.where(
        query_ingredients.map { "EXISTS (SELECT 1 FROM ingredients WHERE ingredients.recipe_id = recipes.id AND ingredients.name ILIKE ?)" }
        .join(" OR "),
        *query_ingredients.map { |i| "%#{i}%" }
      )
    end

    # Add conditions for excluded ingredients
    if params[:exclude].present?
      exclude_ingredients = params[:exclude].split
      recipes_query = recipes_query.where.not(
        exclude_ingredients.map { "EXISTS (SELECT 1 FROM ingredients WHERE ingredients.recipe_id = recipes.id AND ingredients.name ILIKE ?)" }
        .join(" OR "),
        *exclude_ingredients.map { |i| "%#{i}%" }
      )
    end

    # Add conditions for time constraints
    if params[:time].present?
      time_limit = params[:time].to_i
      recipes_query = recipes_query.where("cook_minutes + prep_minutes <= ?", time_limit)
    end

    # Add pagination
    recipes_query = recipes_query.page(params[:page]).per(params[:per] || 10)

    # Fetch and render the recipes as JSON
    render json: recipes_query, each_serializer: RecipeSerializer
  end
end
