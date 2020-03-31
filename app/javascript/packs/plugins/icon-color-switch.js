function iconColorSwitch() {
  const userIcon = document.getElementById("signbutton");
  const bookingIcon = document.querySelector(".fa-calendar-alt").parentElement.parentElement;
  const otherIcons = document.querySelector(".active");
  userIcon.addEventListener('click', (event) => {
    userIcon.classList.add("orange");
    bookingIcon.classList.remove("active");
    otherIcons.classList.remove("active");
  });
}


export{iconColorSwitch};
