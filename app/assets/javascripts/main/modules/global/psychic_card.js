Module("IHP.Components.PsychicCard", function(PsychicCard) {
  "use strict";

  var getPsychicCard = function(e) {
    return $(e.target).closest(".psychic");
  };

  var getPsychicId = function(e) {
    var psychicCard = getPsychicCard(e);
    return psychicCard.attr("data-psychic-id");
  };

  PsychicCard.fn.initialize = function(el) {
    this.el = el;
    this.addEventListeners();
  };

  PsychicCard.fn.addEventListeners = function() {
    this.el.on("mouseenter", ".psychic", this.whenMouseEntersPsychic.bind(this));
    this.el.on("mouseleave", ".psychic", this.whenMouseLeavesPsychic.bind(this));

    this.el.on("click", ".psychic-card-favorite-off", this.whenPsychicIsFavorited.bind(this));
    this.el.on("click", ".psychic-card-favorite-on", this.whenPsychicIsUnfavorited.bind(this));

    this.el.on("click", ".psychic-card-reviews", this.whenReviewButtonIsClicked.bind(this));
  };

  PsychicCard.fn.whenMouseEntersPsychic = function(e) {
    var psychicCard = getPsychicCard(e);
    $(".psychic-card-action", psychicCard).fadeIn();
  };

  PsychicCard.fn.whenMouseLeavesPsychic = function(e) {
    var psychicCard = getPsychicCard(e);
    $(".psychic-card-action", psychicCard).fadeOut();
  };

  PsychicCard.fn.whenPsychicIsFavorited = function(e) {
    var psychicCard = getPsychicCard(e);
    $(".psychic-card-favorite-off", psychicCard).
      removeClass("psychic-card-favorite-off").
      addClass("psychic-card-favorite-on")
  };

  PsychicCard.fn.whenPsychicIsUnfavorited = function(e) {
    var psychicCard = getPsychicCard(e);
    $(".psychic-card-favorite-on", psychicCard).
      removeClass("psychic-card-favorite-on").
      addClass("psychic-card-favorite-off")
  };

  PsychicCard.fn.whenReviewButtonIsClicked = function(e) {
    var psychicId = getPsychicId(e);
    location.href = "/psychic/" + psychicId + "/about#reviews";
  };
})
