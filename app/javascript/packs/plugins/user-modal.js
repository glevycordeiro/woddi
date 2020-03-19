function userModal() {
<<<<<<< HEAD
  const element = document.selectElementById("userModal");
  element.addEventListener("click", event => {
    const libutton = document.selectElementById("modal");
    document.libutton.classList.add(" active");
  });
}
=======
  const element = document.getElementById("userModal");
    element.addEventListener('click', (event) => {
      const libutton = document.getElementById("modal");
      document.libutton.classList.add(' active');
>>>>>>> 8f3bd4bb4aab24055affb2ea4a533cfb3ba35759

export { userModal };
