function toggleMenu() {
    const menu = document.querySelector(".menu-links");
    const icon = document.querySelector(".hamburger-icon");
    menu.classList.toggle("open");
    icon.classList.toggle("open");
  }
  var typed = new Typed('#element', {
    strings: ['Web Developer', 'Video editor','AI - ML Enthusiast'],
    typeSpeed: 50,
  });