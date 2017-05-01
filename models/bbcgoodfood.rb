class Bbcgoodfood
  # Searches for recipes on Food.com using user supplied ingredient
  def search_for_recipes_with(ingredient)
    ingredient = ingredient.split(" ").join("+")
    url = "https://www.bbcgoodfood.com/search/recipes?query=#{ingredient}"
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')
    return build_search_results_array(doc)
  end

  # Method returns an array of recipe names given a Nokogiri doc of BBC Good Food
  def return_names_array(doc)
    names = doc.css(".search-content .teaser-item__title a span")
    recipe_names = []
    names.each do |element|
      recipe_names << element.text
    end
    return recipe_names
  end

  # Method returns an array of recipe descriptions given a Nokogiri doc of BBC Good Food
  def return_descriptions_array(doc)
    descriptions = doc.css(".search-content .field-item.even")
    recipe_descriptions = []
    descriptions.each do |element|
      recipe_descriptions << element.text
    end
    return recipe_descriptions
  end

  # Method returns an array of recipe durations given a Nokogiri doc of BBC Good Food
  def return_durations_array(doc)
    durations = doc.css(".search-content .teaser-item__info-item--total-time")
    recipe_durations = []
    durations.each do |element|
      recipe_durations << element.text.strip
    end
    return recipe_durations
  end

  # Method returns an array of recipe difficulties given a Nokogiri doc of BBC Good Food
  def return_difficulties_array(doc)
    difficulties = doc.css(".search-content .teaser-item__info-item--skill-level")
    recipe_difficulties = []
    difficulties.each do |element|
      recipe_difficulties << element.text.strip
    end
    return recipe_difficulties
  end

  # Method returns an array of recipe links given a Nokogiri doc of BBC Good Food
  def return_links_array(doc)
    links = doc.css(".search-content .teaser-item__title a")
    recipe_links = []
    links.each do |element|
      recipe_links << "https://www.bbcgoodfood.com" + element.attribute('href').value
    end
    return recipe_links
  end

  # Method returns an array of search results given a Nokogiri doc of BBC Good Food
  # Each search result is contained in a hash
  def build_search_results_array(doc)
    names = return_names_array(doc)
    descrs = return_descriptions_array(doc)
    durs = return_durations_array(doc)
    diffs = return_difficulties_array(doc)
    links = return_links_array(doc)

    search_results = []

    names.each_with_index do |_name, i|
      search_results << { name: names[i], descr: descrs[i], dur: durs[i], diff: diffs[i], link: links[i] }
    end

    return search_results
  end
end
