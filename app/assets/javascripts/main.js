$(document).ready(function() {
  var mapOptions = {
    center: new google.maps.LatLng(8.189742, 3.164063),
    zoom: 2
  };
  var map = new google.maps.Map(document.getElementById("map-canvas"),
    mapOptions);
});