function userModal() {
  const element = document.getElementById("userModal");
  element.addEventListener("click", event => {
    const libutton = document.getElementById("modal");
    document.libutton.classList.add(" active");
  });
}

export { userModal };
