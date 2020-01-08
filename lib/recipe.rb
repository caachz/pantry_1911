class Recipe
  attr_reader :name, :total_ingredients

  def initialize(name)
    @name = name
    @total_ingredients = {}
  end

  def ingredients_required
    @total_ingredients
  end

  def add_ingredient(ingredient, quantity)
    @total_ingredients[ingredient] = quantity
  end

  def amount_required(ingredient)
    @total_ingredients.find do |key, value|
      key == ingredient
  end[1]
  end

  def ingredients
    only_ingredients = []
    @total_ingredients.map do |key, value|
      only_ingredients << key
    end
    only_ingredients
  end

  def total_calories
    @total_ingredients.sum do |key, value|
      key.calories * value
  end
  end
end
