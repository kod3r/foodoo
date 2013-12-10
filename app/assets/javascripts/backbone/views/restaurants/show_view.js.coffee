V1foodoo.Views.Restaurants ||= {}

class V1foodoo.Views.Restaurants.ShowView extends Backbone.View
  template: JST["restaurants/show"]

  render: ->
    (@$el).html( @template(@model.toJSON()) )
    @
