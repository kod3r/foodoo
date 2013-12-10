V1foodoo.Views.Restaurants ||= {}

class V1foodoo.Views.Restaurants.IndexView extends Backbone.View
  template: JST["backbone/templates/restaurants/index"]

  render: ->
    (@$el).html( @template(@collection.toJSON()) )
    @
