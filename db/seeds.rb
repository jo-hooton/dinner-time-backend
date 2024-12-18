require 'json'

recipes_data = JSON.parse(File.read(Rails.root.join('db', 'recipes-en.json')))

recipes_data.each do |recipe_data|
  recipe = Recipe.create!(
    title: recipe_data['title'],
    cook_minutes: recipe_data['cook_time'],
    prep_minutes: recipe_data['prep_time'],
    rating: recipe_data['ratings'],
    image: CGI.parse(recipe_data['image']).flat_map(&:last).last
  )

  # Create ingredients for each recipe
  recipe_data['ingredients'].each do |ingredient|
    recipe.ingredients.create!(name: ingredient)
  end
end
