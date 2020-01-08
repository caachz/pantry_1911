require 'minitest/autorun'
require 'minitest/pride'
require './lib/ingredient'
require './lib/recipe'
require './lib/pantry'
require './lib/cook_book'

class CookBookTest < Minitest::Test

  def test_it_exists
    cookbook = CookBook.new

    assert_instance_of CookBook, cookbook
  end

  def test_it_can_add_recipes
    cookbook = CookBook.new
    ingredient1 = Ingredient.new("Cheese", "C", 100)
    ingredient2 = Ingredient.new("Macaroni", "oz", 30)
    ingredient3 = Ingredient.new("Ground Beef", "oz", 100)
    ingredient4 = Ingredient.new("Bun", "g", 1)
    recipe1 = Recipe.new("Mac and Cheese")
    recipe2 = Recipe.new("Burger")

    recipe1.add_ingredient(ingredient1, 2)
    recipe1.add_ingredient(ingredient2, 8)
    recipe2.add_ingredient(ingredient3, 4)
    recipe2.add_ingredient(ingredient4, 100)

    assert_equal [], cookbook.recipes

    cookbook.add_recipe(recipe1)
    cookbook.add_recipe(recipe2)

    assert_equal [recipe1, recipe2], cookbook.recipes
  end

  def test_ingredients_builder_creates_an_array_of_hashes_with_each_ingredient_and_quantity_needed
    cookbook = CookBook.new
    ingredient1 = Ingredient.new("Cheese", "C", 100)
    ingredient2 = Ingredient.new("Macaroni", "oz", 30)
    ingredient3 = Ingredient.new("Ground Beef", "oz", 100)
    ingredient4 = Ingredient.new("Bun", "g", 1)
    recipe1 = Recipe.new("Mac and Cheese")
    recipe2 = Recipe.new("Burger")

    recipe1.add_ingredient(ingredient1, 2)
    recipe1.add_ingredient(ingredient2, 8)
    recipe2.add_ingredient(ingredient3, 4)
    recipe2.add_ingredient(ingredient4, 100)

    cookbook.add_recipe(recipe1)
    cookbook.add_recipe(recipe2)

    assert_equal [{:ingredient=>"Macaroni", :amount=>"8 oz"}, {:ingredient=>"Cheese", :amount=>"2 C"}], cookbook.ingredients_builder(recipe1)

    assert_equal [{:ingredient=>"Ground Beef", :amount=>"4 oz"}, {:ingredient=>"Bun", :amount=>"100 g"}], cookbook.ingredients_builder(recipe2)
  end

  def test_details_builder_returns_a_hash_of_ingredients_and_total_calories
    cookbook = CookBook.new
    ingredient1 = Ingredient.new("Cheese", "C", 100)
    ingredient2 = Ingredient.new("Macaroni", "oz", 30)
    ingredient3 = Ingredient.new("Ground Beef", "oz", 100)
    ingredient4 = Ingredient.new("Bun", "g", 1)
    recipe1 = Recipe.new("Mac and Cheese")
    recipe2 = Recipe.new("Burger")

    recipe1.add_ingredient(ingredient1, 2)
    recipe1.add_ingredient(ingredient2, 8)
    recipe2.add_ingredient(ingredient3, 4)
    recipe2.add_ingredient(ingredient4, 100)

    cookbook.add_recipe(recipe1)
    cookbook.add_recipe(recipe2)
    result1 = {:ingredients=>[{:ingredient=>"Macaroni", :amount=>"8 oz"}, {:ingredient=>"Cheese", :amount=>"2 C"}], :total_calories=>440}

    assert_equal result1, cookbook.details_builder(recipe1)

    result2 = {:ingredients=>[{:ingredient=>"Ground Beef", :amount=>"4 oz"}, {:ingredient=>"Bun", :amount=>"100 g"}], :total_calories=>500}

    assert_equal result2, cookbook.details_builder(recipe2)
  end

  def test_it_returns_summary_of_cook_book
    cookbook = CookBook.new
    ingredient1 = Ingredient.new("Cheese", "C", 100)
    ingredient2 = Ingredient.new("Macaroni", "oz", 30)
    ingredient3 = Ingredient.new("Ground Beef", "oz", 100)
    ingredient4 = Ingredient.new("Bun", "g", 1)
    recipe1 = Recipe.new("Mac and Cheese")
    recipe2 = Recipe.new("Burger")

    recipe1.add_ingredient(ingredient1, 2)
    recipe1.add_ingredient(ingredient2, 8)
    recipe2.add_ingredient(ingredient3, 4)
    recipe2.add_ingredient(ingredient4, 100)

    cookbook.add_recipe(recipe1)
    cookbook.add_recipe(recipe2)

    result = [{:name=>"Mac and Cheese", :details=>{:ingredients=>[{:ingredient=>"Macaroni", :amount=>"8 oz"}, {:ingredient=>"Cheese", :amount=>"2 C"}], :total_calories=>440}}, {:name=>"Burger", :details=>{:ingredients=>[{:ingredient=>"Ground Beef", :amount=>"4 oz"}, {:ingredient=>"Bun", :amount=>"100 g"}], :total_calories=>500}}]

    assert_equal result, cookbook.summary
  end
end
