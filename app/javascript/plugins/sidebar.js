const openSideBar = () => {
  const iconFilter = document.querySelector("#sidebarCollapse");
  iconFilter.addEventListener("click", event => {
    console.log("hey");
    document.querySelector("#sidebar").classList.toggle("active");
  });

  const sidenarClose = document.querySelector("#sidebarClose");
  sidenarClose.addEventListener("click", event => {
    console.log("hey");
    document.querySelector("#sidebar").classList.toggle("active");
  });
};

export { openSideBar };
