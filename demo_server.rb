require 'rack'
require_relative 'lib/controller_base'
require_relative 'lib/router'

$recipe_index = [
  { id: 1, name: "Chocolate Chip Cookies" },
  { id: 2, name: "Brownies" },
]

$recipes = [
  { id: 1, recipe_id: 1, name: 'Chocolate Chip Cookies', ingredients: "2 1/4 cups all-purpose flour, 1 teaspoon baking soda, 1 teaspoon salt, 1 cup (2 sticks) butter softened, 3/4 cup granulated sugar, 3/4 cup packed brown sugar, 1 teaspoon vanilla extract, 2 large eggs, 2 cups semi-sweet chocolate chips, 1 cup chopped nuts.", directions: 'Preheat oven to 375 degrees. Combine flour, baking soda and salt in small bowl. Beat butter, granulated sugar, brown sugar and vanilla extract in large mixer bowl until creamy. Add eggs, one at a time, beating well after each addition. Gradually beat in flour mixture. Stir in morsels and nuts. Drop by rounded tablespoon onto ungreased baking sheets. Bake for 9 to 11 minutes or until golden brown. Cool on baking sheets for 2 minutes. Remove to wire racks to cool completely.' },
  { id: 2, recipe_id: 2, name: 'Brownies', ingredients: "1/2 cup vegetable oil, 1 cup sugar, 1 teaspoon vanilla, 2 large eggs, 1/4 teaspoon baking powder, 1/3 cup cocoa powder, 1/4 teaspoon salt, 1/2 cup flour", directions: "Preheat oven to 350 degrees. Mix oil and sugar until well blended. Add eggs and vanilla, stir just until blended. Mix all dry ingredients in a separate bowl. Stir dry ingredients into the oil/sugar mixture. Pour into greased 9 x 9 square pan. Bake for 20 minutes or until sides just start to pull away from the pan. Cool completely before cutting." }
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
