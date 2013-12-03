Module("IHP.Pages.HomeIndex", function(HomeIndex) {
  "use strict";

  HomeIndex.fn.initialize = function(el) {
    this.el = $(el);
    this.search = Module.run("IHP.Components.PsychicSearch", [this.el]);

    this.addEventListeners();
  };

  HomeIndex.fn.addEventListeners = function() {
    this.el.on("click", ".sign_up_link", this.redirectToSignup);
  };

  HomeIndex.fn.redirectToSignup = function(e) {
    e.preventDefault();
    window.location.href = "/users/sign_up";
  };
});

Module("IHP.Pages.HomeContact", function(HomeIndex) {
  "use strict";

  HomeIndex.fn.initialize = function(el) {
    this.el = $(el);
    $("#message_phone", this.el).mask("999-999-9999");
  };
});
