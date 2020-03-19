import "bootstrap";

import { readURL } from "./plugins/image-loader";

import "mapbox-gl/dist/mapbox-gl.css"; // <-- you need to uncomment the stylesheet_pack_tag in the layout!

import { initMapbox } from "../plugins/init_mapbox";

initMapbox();

import { initStarRating } from "../plugins/init_star_rating";

initStarRating();

import { openReviewModal } from "./plugins/review-modal";

openReviewModal();

import { openBookingModal } from "./plugins/booking-modal";

openBookingModal();

import { userModal } from "./plugins/user-modal";

userModal();
const iconFilter = document.querySelector("#sidebarCollapse");
iconFilter.addEventListener("click", event => {
  console.log("hey");
  document.querySelector("#sidebar").classList.toggle("active");
});
