class RecipesController < ApplicationController
  def index
    # pg search for recipes containing specified ingredients
    @recipes = params[:query].present? ? Recipe.search_by_ingredients(params[:query]) : Recipe.all

    # filter by prep + cook time if specified
    if params[:time].present?
      @recipes = @recipes.where("cook_minutes + prep_minutes <= ?", params[:time])
    end

    # exclude recipes containing specified ingredients
    if params[:exclude].present?
      exclude_ingredients = params[:exclude].split
      exclude_ingredients.each do |ingredient|
        @recipes = @recipes.where.not("ingredients::text ILIKE ?", "%#{ingredient}%")
      end
    end

    # pagination
    @recipes = @recipes.page(params[:page]).per(params[:per] || 10)

    render json: @recipes
  end
end
