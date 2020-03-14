import "bootstrap";

import {readURL} from "./plugins/image-loader";

import "mapbox-gl/dist/mapbox-gl.css"; // <-- you need to uncomment the stylesheet_pack_tag in the layout!

import { initMapbox } from "../plugins/init_mapbox";

initMapbox();

import { initStarRating } from '../plugins/init_star_rating';

initStarRating();

const elements = document.querySelectorAll(".create-review");

elements.forEach((element) => {
  element.addEventListener('click', (event) => {
    const bookingId = element.dataset.bookingId;
    const boxName = element.dataset.boxName;
    const injectingBoxName = document.getElementById("box-name");
    injectingBoxName.innerHTML = boxName;
    const injectingActionToReview = document.getElementById("new_review");
    injectingActionToReview.action = "bookings/" + bookingId + "/reviews";
    const targetHiddenModalButton = document.getElementById("create-review-modal-hidden-button");
    targetHiddenModalButton.click();
  });
});

