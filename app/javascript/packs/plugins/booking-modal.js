function openBookingModal() {
  const elements = document.querySelectorAll(".card-box-lesson");

  elements.forEach((element) => {
    element.addEventListener('click', (event) => {
      const boxLessonId = element.dataset.boxLessonId;
      const injectingBoxLessonId = document.getElementById("order_box_lesson");
      injectingBoxLessonId.value = boxLessonId;

      const boxName = element.dataset.boxName;
      const injectingBoxName = document.getElementById("modal-box-name");
      injectingBoxName.innerHTML = boxName;

      const boxLessonDateTime = element.dataset.boxLessonDateTime;
      const injectingBoxLessonDateTime = document.getElementById("modal-start-date-time");
      injectingBoxLessonDateTime.innerHTML = boxLessonDateTime;

      const boxLessonPriceCents = element.dataset.boxLessonPriceCents;
      const injectingBoxLessonPriceCents = document.getElementById("modal-price");
      injectingBoxLessonPriceCents.innerHTML = parseFloat(boxLessonPriceCents)/100 + "€";

      const targetHiddenModalButton = document.getElementById("create-booking-modal-hidden-button");
      targetHiddenModalButton.click();
    });
  });
}

export{openBookingModal};
