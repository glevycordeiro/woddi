function userModal() {
  const element = document.getElementById("userModal");
  if (element) {
    element.addEventListener('click', (event) => {
      const libutton = document.getElementById("modal");
      document.libutton.classList.add(' active');
    });
  }
};

export{userModal};