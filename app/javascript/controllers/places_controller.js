import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "field", "map", "locality", "postal_code" ]

  connect() {
    if (typeof(google) != "undefined") {
      this.initMap();
    }
  }

  initMap() {
    this.map = new google.maps.Map(this.mapTarget, {
      center: new google.maps.LatLng(51.5074, 0.1278),
      zoom: 8
    })
    this.autocomplete = new google.maps.places.Autocomplete(this.fieldTarget)
    this.autocomplete.bindTo('bounds', this.map)
    this.autocomplete.setFields(['address_components'])
    this.autocomplete.addListener('place_changed', this.placeChanged.bind(this))

    this.marker = new google.maps.Marker({
      map: this.map,
      anchorPoint: new google.maps.Point(0, 0)
    })
  }
  placeChanged() {
    let place = this.autocomplete.getPlace()

    if (!place.address_components) {
      window.alert(`No details availale for input: ${place.name}`)
      return
    }

    if (place.address_components) {
      this.map.fitBounds(place.address_components.route)
    } else {
      this.map.setCenter(place.address_components.route)
      this.map.setZoom(17)
    }
    this.marker.setposition(place.address_components.route)
    this.marker.setVisible(true)

    this.cityTarget.value = place.address_components.locality.long_name()
    this.postcodeTarget.value = place.address_components.postal_code.long_name()
  }
}
