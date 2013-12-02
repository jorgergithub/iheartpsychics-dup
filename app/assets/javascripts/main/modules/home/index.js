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


  PsychicSearch.fn.applySlider = function() {
    var initialValue = 5; 
    $(".container-nav-price-slider").slider({
      range: "min",
      min: 1,
      max: 15,
      value: initialValue,
      slide: function( event, ui ) {
        $("a.ui-slider-handle", this).text("$" + ui.value );
        // search here....
      }
    });
    $("a.ui-slider-handle" ).text(initialValue);
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
  
    this.applySlider();
  };

  PsychicSearch.fn.whenKeyPressedOnSearch = function(e) {
    clearTimeout(this.typingTimer);
  };

  PsychicSearch.fn.whenKeyReleasedOnSearch = function(e) {
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
    if (this.status == "available") {
      this.status = "all";
    }
    else {
      this.status = "available";
    }
    this.executeSearch();
  };

  PsychicSearch.fn.whenFeaturedIsClicked = function(e) {
    e.preventDefault();
    this.page = 1;
    this.featured = !this.featured;
    this.executeSearch();
  };

  PsychicSearch.fn.whenMoreIsClicked = function(e) {
    e.preventDefault();
    this.page = this.page + 1;
    this.executeSearch(true);
  };

  PsychicSearch.fn.clearSelectedSpecialty = function() {
    this.specialtySearch.find(".specialty-search-selected").removeClass("specialty-search-selected");
  };

  PsychicSearch.fn.clearSearches = function() {
    this.status = "all";
    this.featured = false;
    this.clearSelectedSpecialty();
    this.clearNameSearch();
  };

  PsychicSearch.fn.clearNameSearch = function() {
    var textSearchBox = $(".container-nav-search-input", this.el);
    textSearchBox.val("");
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

  PsychicSearch.fn.markSelected = function(selector, condition) {
    if (condition) {
      $(selector).addClass("search-selected");
    }
    else {
      $(selector).removeClass("search-selected");
    }
  }

  PsychicSearch.fn.updateSearchDisplay = function() {
    this.markSelected(".search-status-available", this.status == "available");
    this.markSelected(".search-featured", this.featured);
    this.markSelected(".specialty-search-link", this.selectedSpecialty());
  };

  PsychicSearch.fn.executeSearch = function(append) {
    this.updateSearchDisplay();

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

    if (append) {
      data.append = "true";
    }

    data.page = this.page;

    this.showLoading();
    var promise = $.ajax("/psychic/search", { data: data });

    var that = this;
    promise.done(function(data, textStatus, jqXHR) {
      that.hideLoading();
      if (append) {
        $(".container-search-result").append(data);
      }
      else {
        $(".container-search-result").html(data);
      }
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

Module("IHP.Pages.HomeContact", function(HomeIndex) {
  "use strict";

  HomeIndex.fn.initialize = function(el) {
    this.el = $(el);
    $("#message_phone", this.el).mask("999-999-9999");
  };
});
