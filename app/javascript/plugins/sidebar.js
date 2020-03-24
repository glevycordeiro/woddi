const openSideBar = () => {
  const iconFilter = document.querySelector("#sidebarCollapse");

  if (iconFilter) {
    iconFilter.addEventListener("click", event => {
      document.querySelector("#sidebar").style.left = "0px";
    });
  }

  const sidenarClose = document.querySelector("#sidebarClose");

  if (sidenarClose) {
    sidenarClose.addEventListener("click", event => {
      document.querySelector("#sidebar").style.left = "-260px";
    });
  }
};

export { openSideBar };
