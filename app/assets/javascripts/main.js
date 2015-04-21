(function() {
  var map;

  var layMarker = function(coords, location, url) {
    var infowindow = new google.maps.InfoWindow({
      content: "<h3>"+location+"</h3><br/><a target=\"_blank\" href="+url+">"+url+"</a>"
    });

    var marker = new google.maps.Marker({
      position: new google.maps.LatLng(coords[0], coords[1]),
      map: map,
      title: location
    });

    google.maps.event.addListener(marker, 'click', function() {
      infowindow.open(map,marker);
    });
  };

  var subscribeToChannel = function() {
    var pubnub = PUBNUB.init({     
      publish_key   : 'pub-c-3c0435e9-c157-4dee-bc87-ae68895b017c',                             
      subscribe_key : 'sub-c-f5cb54c2-e466-11e4-9a1e-02ee2ddab7fe'
    });

    pubnub.subscribe({                                      
      channel : "broadcast_added",
      message : function(message,env,channel){
        var message = JSON.parse(message);
        layMarker(message.coords, message.location, message.periscope_url);
      }
    });
  };

  var createMap = function() {
    var mapOptions = {
      center: new google.maps.LatLng(8.189742, 3.164063),
      zoom: 2
    };
    map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
  };

  $(document).ready(function() {
    createMap();
    subscribeToChannel();
  });
})();