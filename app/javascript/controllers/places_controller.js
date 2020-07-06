// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'field', 'map', 'latitude', 'longitude' ]

  connect() {
    if (typeof(google) != "undefined") {
      this.initMap();
    }
  }

  initMap() {
    // initialize google map (preview)
    this.map = new google.maps.Map(this.mapTarget, {
      center: new google.maps.LatLng(51.5074, 0.1278),
      zoom: 10
    })
    // initialize google places js (address autocomplete)
    this.autocomplete = new google.maps.places.Autocomplete(this.fieldTarget)
    // connect autocomplete to map preview
    this.autocomplete.bindTo('bounds', this.map)
    // Define the fields you need autocomplete to return
    this.autocomplete.setFields(['address_components', 'geometry', 'icon', 'name'])
    // when user selects a place, call function 'placeChanged'
    this.autocomplete.addListener('place_changed', this.placeChanged.bind(this))

    // Create a default marker
    this.marker = new google.maps.Marker({
      map: this.map,
      anchorPoint: new google.maps.Point(0, 29)
    })
  }

  placeChanged() {
    // get the place from user input
    let place = this.autocomplete.getPlace()

    // return if the selected place has no real location
    if (!place.address_components) {
      window.alert(`No details availale for input: ${place.name}`)
      return
    }

    // if enough information, move the map to our location in the best zoom option (viewport)
    if (place.geometry.viewport) {
      this.map.fitBounds(place.geometry.viewport)
    } else {
      this.map.setCenter(place.geometry.location)
      this.map.setZoom(17)
    }

    // Put marker in selected location
    this.marker.setPosition(place.geometry.location)
    this.marker.setVisible(true)

    // autocomplete hidden form fields with coordinates
    this.latitudeTarget.value = place.geometry.location.lat()
    this.longitudeTarget.value = place.geometry.location.lng()
  }

  // prevent sending form while selecting location with enter
  keydown(event) {
    if (event.key == 'Enter') {
      event.preventDefault()
    }
  }
}
