V1foodoo.Views.Restaurants ||= {}

class V1foodoo.Views.Restaurants.RestaurantView extends Backbone.View
  template: JST["backbone/templates/restaurants/restaurant"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
