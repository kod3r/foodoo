class V1foodoo.Routers.RestaurantsRouter extends Backbone.Router
  initialize: (options) ->
    @restaurants = new V1foodoo.Collections.RestaurantsCollection()
    @restaurants.reset options.restaurants

  routes:
    "new"      : "newRestaurant"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"       : "index"
    ""         : "index"

  newRestaurant: ->
    @view = new V1foodoo.Views.Restaurants.NewView(collection: @restaurants)
    $("#restaurants").html(@view.render().el)

  index: ->
    @view = new V1foodoo.Views.Restaurants.IndexView(restaurants: @restaurants)
    $("#restaurants").html(@view.render().el)

  show: (id) ->
    restaurant = @restaurants.get(id)

    @view = new V1foodoo.Views.Restaurants.ShowView(model: restaurant)
    $("#restaurants").html(@view.render().el)

  edit: (id) ->
    restaurant = @restaurants.get(id)

    @view = new V1foodoo.Views.Restaurants.EditView(model: restaurant)
    $("#restaurants").html(@view.render().el)
