class Pantry
  attr_reader :stock

  def initialize
    @stock = {}
  end

  def stock_check(ingredient)
    total = @stock.sum do |key, value|
      value if key == ingredient
    end
  end

  def restock(ingredient, amount)
    if @stock[ingredient] == nil
      @stock[ingredient] = amount
    else
      @stock[ingredient] += amount
    end
  end

  def enough_ingredients_for?(recipe)
    result = true
    recipe.total_ingredients.each do |key, value|
      result = false if @stock[key] == nil || @stock[key] < value
    end
    result
  end
end
