require 'rack'
require_relative 'lib/controller_base'
require_relative 'lib/router'

$recipe_index = [
  { id: 1, name: "Crepes" },
  { id: 2, name: "French Toast" },
  { id: 3, name: "Pancakes" },
  { id: 4, name: "Waffles" },
  { id: 5, name: "Vegetable Omelet" },
]

$recipes = [
  { id: 1, recipe_id: 1, name: "Crepes", ingredients: "1 cup all-purpose flour, 2 eggs, 1/2 cup milk, 1/2 cup water, 1/4 teaspoon salt, 2 tablespoons melted butter", directions: "In a large mixing bowl, whish together the flour and the eggs. radually add in the milk and water, stirring to combine. Add the salt and butter and beat until smooth. Heat a lightly oiled griddle or frying pan over medium high heat. Pour or scoop the batter onto the griddle, using approximately 1/4 cup for each crepe. Tilt the pan with a circular motion so that the batter coats teh surface evenly. Cook the crepe for about 2 minutes, until the bottom is light bronw. Loosen with a spatula, turn and cook the other side."},
  { id: 2, recipe_id: 2, name: "French Toast", ingredients: "6 thick slices of bread, 2 eggs, 2/3 cup milk, 1/4 teaspoon groun dcinnamon, 1/4 teacspoon ground nutmeg(optional), 1 teaspoon vanilla extract, salt to taste", directions: "Beat together egg, milk, salt, desired spices and vanilla. Heat a lightly oiled girddle or skillet over mideium-high heat. Dunk each slice of bread in egg mixture, soaking both sides. Place in pan, and cook on both sides until golden. Serve hot." },
  { id: 3, recipe_id: 3, name: 'Pancakes', ingredients: "1 1/2 cups all-purpose flour, 3 1/2 teaspoons bakign powder, 1 teaspoon salt, 1 tablespoon white sugar, 1 1/4 cups milk, 1 egg, 3 tablespoons melted butter", directions: "In a large bowl, sift together the flour, baking powder, salt and sugar. Make a well in the center and pour in the milk, egg and melted butter. Mix until smooth. Heat a lightly oiled griddle or frying pan over medium high heat. Pour or scoop the batter onto th griddle, using approximately 1/4 cup for each pancake. Brown on both sides and serve hot." },
  { id: 4, recipe_id: 4, name: 'Waffles', ingredients: "2 eggs, 2 cups all-purpose flour, 1 3/4 cups milk, 1/2 cup vegetable oil, 1 tablespoon white sugar, 4 teaspoons baking powder, 1/4 teaspoon salt, 1/2 teaspoon vanilla extract", directions: "Preheat waffle iron. Beat eggs in a large bowl with hand beater until fluffy. Beat in flour, milk, vegetable oil, sugar, baking poweder, salt and vanilla, just until smooth. Spray preheated waffle iron with non-stick cooking spray. Pour mix onto hot waffle iron. Cook until golden brown." },
  { id: 5, recipe_id: 5, name: "Vegetable Omelet", ingredients: "2 tablespoons butter, 1 chopped small onion, 1 chopped green bell pepper, 4 eggs, 2 tablespoons milk, 3/4 teaspoon salt, 1/8 teaspoon black pepper, 2 ounces shredded cheddar cheese", directions: "Melt one tablespoon butter in a medium skillet over medium heat. Place onion and bell pepper inside of the skillet. Cook for 4 to 5 minutes stirring occassionally until tender. Remove the vegetables from heat and transfer them to another bowl. Beat the eggs with the milk, 1/2 teaspoon salt and pepper. Melt the remaining butter in the skillet over medium heat. Add the egg mixture and cook the egg for 2 minutes or until the eggs begin to set on the bottom of the pan. Gently lift the edges of the omelet with a spatula to let the uncooked part of the eggs flow toward the edges and cook. Continue cooking for 2 to 3 minutes or until the center of the omelet starts to look dry. Sprinkle the cheese over the omelet and spoon the vegetable mixture into the center of the omelet. Using a spatula gently fold one edge of the omelet over the vegetables. Let the omelete cook for another two minutes or until the cheese melts. Slide the omelet out of the skillet onto a place and serve." }
]

class RecipesController < ControllerBase

  def index
    @recipes = $recipe_index
    render :index
  end

  def show
    id = Integer(params['recipe_id'])
    @recipe = $recipes.select do |recipe|
      recipe[:id] == id
    end
    render :show
  end

end

router = Router.new
router.draw do
  get Regexp.new("^/recipes$"), RecipesController, :index
  get Regexp.new("^/recipes/(?<recipe_id>\\d+)$"), RecipesController, :show
end

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  router.run(req, res)
  res.finish
end

Rack::Server.start(
  app: app,
  Port: 3000
)
