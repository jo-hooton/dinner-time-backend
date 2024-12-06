class RecipesController < ApplicationController
  def index
    if params[:query].present?
      @recipes = Recipe.search_by_ingredients(params[:query])
    else
      @recipes = Recipe.all
    end

    @recipes = @recipes.where("cook_minutes + prep_minutes <= ?", params[:time]) if params[:time].present?
    @recipes = @recipes.page(params[:page]).per(params[:per] || 9)

    render json: @recipes
  end
end