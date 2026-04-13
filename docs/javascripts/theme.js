// Force dark (slate) as default if the user has never explicitly chosen a theme
(function () {
  var stored = localStorage.getItem(".__palette");
  if (!stored) {
    localStorage.setItem(".__palette", JSON.stringify({ index: 0 }));
  }
})();
