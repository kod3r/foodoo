class V1foodoo.Models.Restaurant extends Backbone.Model
  paramRoot: 'restaurant'

  defaults:
    name: null
    cuisine: null
    price: null
    delivery: null
    takeout: null
    reservations: null
    image: null
    yelp_url: null

class V1foodoo.Collections.RestaurantsCollection extends Backbone.Collection
  model: V1foodoo.Models.Restaurant
  url: '/restaurants'
