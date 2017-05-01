class Recipe
  attr_reader :name, :descr, :dur, :diff, :link
  attr_accessor :made
  def initialize(name, description, duration = "none", difficulty = "none", link = "none")
    @name = name
    @descr = description
    @dur = duration
    @diff = difficulty
    @link = link
    @made = false
  end
end
