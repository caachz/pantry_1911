class CookBook
  attr_reader :recipes

  def initialize
    @recipes = []
  end

  def add_recipe(recipe)
    @recipes << recipe
  end

  def ingredients_builder(recipe)
    ingredients_array = []
      recipe.total_ingredients.each do |ingredient|
        ingredient_hash = {}
        ingredient_hash[:ingredient] = ingredient[0].name
        ingredient_hash[:amount] = ingredient[1].to_s + " " + ingredient[0].unit
        ingredient_hash[:calories] = ingredient[0].calories * ingredient[1]
        ingredients_array << ingredient_hash
    end
    sorted = ingredients_array.sort do |a, b|
      b[:calories] <=> a[:calories]
    end
    sorted.map do |ingredient|
      ingredient.delete(:calories)
    end
    sorted
  end

  def details_builder(recipe)
    result = {}
    result[:ingredients] = ingredients_builder(recipe)
    result[:total_calories] = recipe.total_calories
    result
  end

  def summary
    result = []
    @recipes.each do |recipe|
      recipe_hash = {}
      recipe_hash[:name] = recipe.name
      recipe_hash[:details] = details_builder(recipe)
      result << recipe_hash
    end
    result
  end
end
