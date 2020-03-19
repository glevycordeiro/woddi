import "jquery-bar-rating";
import "jquery-bar-rating/dist/themes/css-stars.css";
import $ from "jquery"; // <-- if you're NOT using a Le Wagon template (cf jQuery section)

const initStarRating = () => {
  $("#review_rating").barrating({
    theme: "css-stars",
    initialRating: 1,
    deselectable: false
  });

  $("#search_rating").barrating({
    theme: "css-stars",
    deselectable: false
  });
};

export { initStarRating };
