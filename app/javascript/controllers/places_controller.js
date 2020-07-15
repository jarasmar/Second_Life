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
  static targets = [ 'field', 'map', 'latitude', 'longitude', 'city', 'postcode' ]

  connect() {
    if (typeof(google) != "undefined") {
      this.initMap();
    }
  }

  initMap() {
    // Get coordinates from input or set default to central London
    this.LatLng = new google.maps.LatLng(this.data.get('latitude') || 51.50, this.data.get('longitude') || -0.11)
    // initialize google map (preview)
    this.map = new google.maps.Map(this.mapTarget, {
      center: this.LatLng,
      zoom: (this.data.get('latitude') == null ? 10 : 17)
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
      position: this.LatLng
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

    // Autocomplete postcode/city fields
    let componentForm = {
      locality: 'long_name',
      postal_town: 'long_name',
      postal_code: 'short_name',
      postal_code_prefix: 'short_name'
    }

    console.log(place.address_components)

    for (let i = 0; i < place.address_components.length; i++) {
      let addressType = place.address_components[i].types[0];

      if (addressType === 'postal_code' || addressType === 'postal_code_prefix')  {
        let value = place.address_components[i][componentForm[addressType]];
        this.postcodeTarget.value = value;
      } else if (addressType === 'postal_town' || addressType === 'locality') {
        let value = place.address_components[i][componentForm[addressType]];
        this.cityTarget.value = value;
      }
    }
  }

  // prevent sending form while selecting location with enter
  keydown(event) {
    if (event.key == 'Enter') {
      event.preventDefault()
    }
  }
}
