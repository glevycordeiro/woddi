import mapboxgl from "mapbox-gl";

const initMapbox = () => {
  const mapElement = document.getElementById("map");

  const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([marker.lng, marker.lat]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  };

  if (mapElement) {
    // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: "map",
      style: "mapbox://styles/mapbox/streets-v10"
    });
    const markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach(marker => {
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow); // add this

      new mapboxgl.Marker({ color: "#FF8D06" })
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup) // add this
        .addTo(map);
    });

    fitMapToMarkers(map, markers);

    document
      .getElementById("navigateCurrentLocation")
      .addEventListener("click", function() {
        map.fitBounds([
          [-9.1436407, 38.7276493],
          [-9.161388, 38.760999]
        ]);
      });
  }
};

export { initMapbox };
