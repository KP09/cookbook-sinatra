require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"

require_relative 'models/cookbook'
require_relative 'models/recipe'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

set :bind, '0.0.0.0'

csv_file_path = File.join(__dir__, 'recipes.csv')
cookbook = Cookbook.new(csv_file_path)

get '/' do
  erb :index
end

# USER ACTION: list all recipes in the cookbook
get '/list' do
  @recipes_array = cookbook.all
  erb :list
end

get '/create' do
  @recipes_array = cookbook.all
  erb :create
end

get '/destroy' do
  erb :destroy
end

get '/import' do
  erb :import
end

get '/toggle' do
  erb :toggle
end

