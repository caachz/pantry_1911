require 'minitest/autorun'
require 'minitest/pride'
require './lib/ingredient'

class IngredientTest < Minitest::Test

  def test_it_exists
    ingredient = Ingredient.new("Cheese", "oz", 50)

    assert_instance_of Ingredient, ingredient
  end

  def test_it_has_attributes
    ingredient = Ingredient.new("Cheese", "oz", 50)

    assert_equal "Cheese", ingredient.name
    assert_equal "oz", ingredient.unit
    assert_equal 50, ingredient.calories
  end
end
