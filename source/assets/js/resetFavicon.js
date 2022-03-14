(function () {
  window.addEventListener("DOMContentLoaded", () => {
    var head = document.querySelector("head");
    var faviconLink = head.querySelector("link[rel='icon']");
    var baseHref = window.location.href;
    var sessionStorageHref = sessionStorage.getItem("baseHref");

    if (!sessionStorageHref) {
      sessionStorage.setItem("baseHref", baseHref);
    }

    faviconLink.href =
      sessionStorage.getItem("baseHref") + "assets/img/favicon.ico";
  });
})();
