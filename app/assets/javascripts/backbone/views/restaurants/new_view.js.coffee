V1foodoo.Views.Restaurants ||= {}

class V1foodoo.Views.Restaurants.NewView extends Backbone.View
  template: JST["restaurants/new"]

  events:
    "submit #new-restaurant": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (restaurant) =>
        @model = restaurant
        window.location.hash = "/#{@model.id}"

      error: (restaurant, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
