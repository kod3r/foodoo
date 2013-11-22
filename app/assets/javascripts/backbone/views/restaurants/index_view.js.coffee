V1foodoo.Views.Restaurants ||= {}

class V1foodoo.Views.Restaurants.IndexView extends Backbone.View
  template: JST["backbone/templates/restaurants/index"]

  initialize: () ->
    @options.restaurants.bind('reset', @addAll)

  addAll: () =>
    @options.restaurants.each(@addOne)

  addOne: (restaurant) =>
    view = new V1foodoo.Views.Restaurants.RestaurantView({model : restaurant})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(restaurants: @options.restaurants.toJSON() ))
    @addAll()

    return this
