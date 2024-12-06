class CreateRecipes < ActiveRecord::Migration[8.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.integer :cook_minutes
      t.integer :prep_minutes
      t.float :rating
      t.string :image
      t.jsonb :ingredients, default: [], null: false

      t.timestamps
    end

    add_index :recipes, :ingredients, using: :gin
  end
end
