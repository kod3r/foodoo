#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.V1foodoo =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  initialize: (data) ->
    restaurants = new V1foodoo.Collections.RestaurantsCollection(data.restaurants)
    new V1foodoo.Routers.RestaurantsRouter(restaurants: restaurants)
    Backbone.history.start()
