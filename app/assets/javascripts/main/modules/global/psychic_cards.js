Module("IHP.Components.PsychicCards", function(PsychicCards) {
  "use strict";

  var getPsychicCard = function(e) {
    return $(e.target).closest(".psychic");
  };

  var getPsychicId = function(e) {
    var psychicCard = getPsychicCard(e);
    return psychicCard.attr("data-psychic-id");
  };

  PsychicCards.fn.initialize = function(el) {
    this.el = el;
    this.addEventListeners();
  };

  PsychicCards.fn.addEventListeners = function() {
    this.el.on("mouseenter", ".psychic", this.whenMouseEntersPsychic.bind(this));
    this.el.on("mouseleave", ".psychic", this.whenMouseLeavesPsychic.bind(this));

    this.el.on("click", ".psychic-card-favorite-off", this.whenPsychicIsMarkedAsFavorite.bind(this));
    this.el.on("click", ".psychic-card-favorite-on", this.whenPsychicIsRemovedAsFavorite.bind(this));

    this.el.on("click", ".psychic-card-reviews", this.whenReviewButtonIsClicked.bind(this));
    this.el.on("click", ".psychic-card-phone", this.whenCallbackButtonIsClicked.bind(this));
  };

  PsychicCards.fn.whenMouseEntersPsychic = function(e) {
    var psychicCard = getPsychicCard(e);
    $(".psychic-card-action", psychicCard).fadeIn();
  };

  PsychicCards.fn.whenMouseLeavesPsychic = function(e) {
    var psychicCard = getPsychicCard(e);
    $(".psychic-card-action", psychicCard).fadeOut();
  };

  PsychicCards.fn.whenPsychicIsMarkedAsFavorite = function(e) {
    var psychicCard = getPsychicCard(e);
    var psychicId = getPsychicId(e);

    var promise = $.ajax({
      url: "/client/make_favorite.json?psychic_id=" + psychicId
    });

    promise.done(function() {
      $(".psychic-card-favorite-off", psychicCard).
        removeClass("psychic-card-favorite-off").
        addClass("psychic-card-favorite-on");
    });

    promise.fail(this.handleAjaxError.bind(this));
  };

  PsychicCards.fn.whenPsychicIsRemovedAsFavorite = function(e) {
    var psychicCard = getPsychicCard(e);
    var psychicId = getPsychicId(e);

    var promise = $.ajax({
      url: "/client/remove_favorite.json?psychic_id=" + psychicId
    });

    promise.done(function(data, textStatus, jqXHR) {
      $(".psychic-card-favorite-on", psychicCard).
        removeClass("psychic-card-favorite-on").
        addClass("psychic-card-favorite-off");
    });

    promise.fail(this.handleAjaxError.bind(this));
  };

  PsychicCards.fn.whenCallbackButtonIsClicked = function(e) {
    var psychicId = getPsychicId(e);
    Module.run("IHP.Components.Callbacks", [this.el, psychicId]);
  };

  PsychicCards.fn.handleAjaxError = function(jqXHR, textStatus, errorThrown) {
    var statusCode = jqXHR.status;
    console.log("Ajax Error", statusCode);
    if (statusCode == 401) {
      // unauthorized
    }
  };

  PsychicCards.fn.whenReviewButtonIsClicked = function(e) {
    var psychicId = getPsychicId(e);
    location.href = "/psychic/" + psychicId + "/about#reviews";
  };
})