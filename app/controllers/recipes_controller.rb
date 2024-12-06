class RecipesController < ApplicationController
  def index
    if params[:query].present?
      @recipes = Recipe.search_by_title_and_ingredients(params[:query])
    else
      @recipes = Recipe.all
    end
    render json: @recipes
  end
end