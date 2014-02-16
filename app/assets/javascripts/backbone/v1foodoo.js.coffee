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
    restaurants = new V1foodoo.Collections.RestaurantsCollection()
    restaurants.fetch
      success: (collection) ->
        $('.bubblingG').hide();
        V1foodoo.router = new V1foodoo.Routers.RestaurantsRouter(restaurants: collection)
        Backbone.history.start(pushState: true)

$(document).ready ->
  V1foodoo.initialize()
