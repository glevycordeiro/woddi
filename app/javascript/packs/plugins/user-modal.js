function userModal() {
  const element = document.selectElementById("userModal");
  element.addEventListener("click", event => {
    const libutton = document.selectElementById("modal");
    document.libutton.classList.add(" active");
  });
}

export { userModal };
