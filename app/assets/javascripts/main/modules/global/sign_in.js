Module("IHP.Components.SignIn", function(SignIn) {
  "use strict";

  SignIn.fn.initialize = function(el) {
    this.el = $(el);
    this.user = this.el.find(".user");

    this.signinEl = this.el.find(".user-signin-element");
    this.userLogin = this.el.find("#user_login");

    this.addEventListeners();
  };

  SignIn.fn.addEventListeners = function() {
    this.el.on("click", ".signin", this.whenSignInIsClicked.bind(this));
    this.el.on("click", ".user-close", this.whenCloseIsClicked.bind(this));
  };

  SignIn.fn.toggleSignInArea = function() {
    if (this.signinEl.is(":visible")) {
      this.signinEl.slideUp();
    }
    else {
      this.signinEl.slideDown(function() {
        this.userLogin.focus();
        this.userLogin.select();
      }.bind(this));
    }
  }

  SignIn.fn.whenSignInIsClicked = function(e) {
    e.preventDefault();
    e.stopPropagation();

    this.toggleSignInArea();
  };

  SignIn.fn.whenCloseIsClicked = function(e) {
    e.preventDefault();
    e.stopPropagation();

    this.toggleSignInArea();
  };
});
