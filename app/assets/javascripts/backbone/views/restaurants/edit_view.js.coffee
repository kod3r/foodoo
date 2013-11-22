V1foodoo.Views.Restaurants ||= {}

class V1foodoo.Views.Restaurants.EditView extends Backbone.View
  template : JST["backbone/templates/restaurants/edit"]

  events :
    "submit #edit-restaurant" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (restaurant) =>
        @model = restaurant
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
