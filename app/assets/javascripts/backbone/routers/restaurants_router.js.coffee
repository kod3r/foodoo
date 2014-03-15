class V1foodoo.Routers.RestaurantsRouter extends Backbone.Router
  initialize: (options) ->
    @restaurants = options.restaurants

  routes:
    "new"                : "newRestaurant"
    "restaurants/index"  : "index"
    "restaurants/"       : "index"
    "restaurants"        : "index"
    ":id/edit"           : "edit"
    ":id"                : "show"
    ".*"                 : "index"

  newRestaurant: ->
    @view = new V1foodoo.Views.Restaurants.NewView(collection: @restaurants)
    $("#restaurants").html(@view.render().el)

  index: ->
    @view = new V1foodoo.Views.Restaurants.IndexView(collection: @restaurants)

    # loader bubbles replaced with content on load
    $('.bubblingG').fadeOut()
    $('.addressor, .buttonry').fadeIn(2000)
    $("#restaurants").html(@view.render().el)

  show: (id) ->
    restaurant = @restaurants.get(id)

    @view = new V1foodoo.Views.Restaurants.ShowView(model: restaurant)
    $("#restaurants").html(@view.render().el)

  edit: (id) ->
    restaurant = @restaurants.get(id)

    @view = new V1foodoo.Views.Restaurants.EditView(model: restaurant)
    $("#restaurants").html(@view.render().el)
