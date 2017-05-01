# External requirements
require 'csv'
require 'nokogiri'
require 'open-uri'
require_relative 'recipe'


class Cookbook
  attr_reader :recipes

  def initialize(csv_file_path)
    @csv_path = csv_file_path
    # Instance variable @recipes is an empty array to begin with
    @recipes = []
    # Call the private instantiate_recipes with the csv_file_path
    # which will fill the @recipes array
    instantiate_recipes(csv_file_path)
  end

  # Returns all recipes
  def all
    return @recipes
  end

  # Adds a recipe to the @recipes "database"
  def add_recipe(new_recipe)
    @recipes << new_recipe
    save_data
  end

  # Removes a recipe from the @recipes "database"
  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_data
  end

  # Toggles the 'made' status of a recipe
  def toggle_recipe(recipe)
    recipe.made == false ? recipe.made = true : recipe.made = false
  end

  # !!! PRIVATE METHODS BELOW !!!
  private

  # Method takes the recipes csv file,
  # instantiates a new Recipe object for every line
  # and pushes the object into the @recipes "database"
  def instantiate_recipes(csv_file_path)
    CSV.foreach(csv_file_path) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3], row[4])
    end
  end

  # Saves data to the CSV file
  def save_data
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    filepath = @csv_path

    CSV.open(filepath, 'wb', csv_options) do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name.to_s, recipe.descr.to_s, recipe.dur.to_s, recipe.diff.to_s, recipe.link.to_s, recipe.made]
      end
    end
  end
end
