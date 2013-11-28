Module("IHP.Components.PsychicSearch", function(PsychicSearch) {
  "use strict";

  PsychicSearch.fn.initialize = function(el) {
    this.el = $(el);
    this.specialtySearch = this.el.find(".specialty-search");
    this.page = 1;

    this.textSearchBox = $(this.specialtySearch.find(".container-nav-search-input"));
    this.typingTimer = undefined;
    this.doneTypingInterval = 1000;

    this.clearSearches();
    this.executeSearch();
    this.addEventListeners();
  };

  PsychicSearch.fn.addEventListeners = function() {
    this.el.on("click", ".specialty-search-link", this.whenSpecialtySearchIsClicked.bind(this));
    this.el.on("click", ".specialty-search-item", this.whenSpecialtyItemIsClicked.bind(this));

    this.el.on("click", ".search-status-all", this.whenAllIsClicked.bind(this));
    this.el.on("click", ".search-status-available", this.whenAvailableIsClicked.bind(this));
    this.el.on("click", ".search-featured", this.whenFeaturedIsClicked.bind(this));

    this.el.on("click", ".psychics-more", this.whenMoreIsClicked.bind(this));

    this.el.on("keydown", ".container-nav-search-input", this.whenKeyPressedOnSearch.bind(this));
    this.el.on("keyup", ".container-nav-search-input", this.whenKeyReleasedOnSearch.bind(this));
  };

  PsychicSearch.fn.whenKeyPressedOnSearch = function(e) {
    console.log("KEYDOWN");
    clearTimeout(this.typingTimer);
  };

  PsychicSearch.fn.whenKeyReleasedOnSearch = function(e) {
    console.log("KEYUP");
    this.typingTimer = setTimeout(this.executeSearch.bind(this), this.doneTypingInterval);
  };

  PsychicSearch.fn.whenSpecialtySearchIsClicked = function(e) {
    e.preventDefault();
    this.specialtySearch.toggle();
  };

  PsychicSearch.fn.whenSpecialtyItemIsClicked = function(e) {
    e.preventDefault();
    var target = $(e.target);
    this.clearSelectedSpecialty();
    target.addClass("specialty-search-selected");
    this.executeSearch();
  };

  PsychicSearch.fn.whenAllIsClicked = function(e) {
    e.preventDefault();
    this.clearSearches();
    this.page = 1;
    this.status = "all";
    this.executeSearch();
  };

  PsychicSearch.fn.whenAvailableIsClicked = function(e) {
    e.preventDefault();
    this.page = 1;
    this.status = "available";
    this.executeSearch();
  };

  PsychicSearch.fn.whenFeaturedIsClicked = function(e) {
    e.preventDefault();
    this.page = 1;
    this.featured = true;
    this.executeSearch();
  };

  PsychicSearch.fn.whenMoreIsClicked = function(e) {
    e.preventDefault();
    this.page = this.page + 1;
    this.executeSearch();
  };

  PsychicSearch.fn.clearSelectedSpecialty = function() {
    this.specialtySearch.find(".specialty-search-selected").removeClass("specialty-search-selected");
  };

  PsychicSearch.fn.clearSearches = function() {
    this.status = "all";
    this.featured = false;
    this.clearSelectedSpecialty();
  };

  PsychicSearch.fn.selectedSpecialty = function() {
    var selectedEl = $(this.el.find(".specialty-search-selected"));
    if (selectedEl.length < 1) {
      return;
    }

    var speciality = selectedEl.find("i").attr("class");

    speciality = speciality.replace(/^specialty-search-/, "");
    speciality = speciality.replace(/-/g, "_");

    return speciality;
  };

  PsychicSearch.fn.showLoading = function() {
    $(".container-psychics-loading").show();
  };

  PsychicSearch.fn.hideLoading = function() {
    $(".container-psychics-loading").hide();
  };

  PsychicSearch.fn.executeSearch = function() {
    var data = {};

    var selectedSpecialty = this.selectedSpecialty();

    if (selectedSpecialty) {
      data.speciality = selectedSpecialty;
    }

    if (this.status != "all") {
      data.status = this.status;
    }

    if (this.featured) {
      data.featured = "true";
    }

    var textSearchBox = $(".container-nav-search-input", this.el);
    if (textSearchBox.val()) {
      if (textSearchBox.val().length > 0) {
        data.text = textSearchBox.val();
      }
    }

    data.page = this.page;

    this.showLoading();
    var promise = $.ajax("/psychic/search", { data: data });

    var that = this;
    promise.done(function(data, textStatus, jqXHR) {
      that.hideLoading();
      $(".container-search-result").html(data);
    });

    promise.fail(function(data, textStatus, jqXHR) {
      that.hideLoading();
    });
  };
});

Module("IHP.Pages.HomeIndex", function(HomeIndex) {
  "use strict";

  HomeIndex.fn.initialize = function(el) {
    this.el = $(el);
    this.search = el.find(".container-nav");

    Module.run("IHP.Components.PsychicSearch", [this.el]);

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
