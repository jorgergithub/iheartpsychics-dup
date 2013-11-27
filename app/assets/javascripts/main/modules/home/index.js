Module("IHP.Pages.HomeIndex", function(HomeIndex) {
  "use strict";

  HomeIndex.fn.initialize = function(el) {
    this.el = $(el);
    this.specialtySearch = this.el.find(".specialty-search");

    this.addEventListeners();
  };

  HomeIndex.fn.addEventListeners = function() {
    this.el.on("click", ".specialty-search-link", this.whenSpecialtySearchIsClicked.bind(this));
    this.el.on("click", ".specialty-search-item", this.whenSpecialtyItemIsClicked.bind(this));
  };

  HomeIndex.fn.whenSpecialtySearchIsClicked = function(e) {
    e.preventDefault();
    this.specialtySearch.toggle();
  };

  HomeIndex.fn.whenSpecialtyItemIsClicked = function(e) {
    var target = $(e.target); // .closest(".specialty-search-item");
    e.preventDefault();
    this.specialtySearch.find(".specialty-search-selected").removeClass("specialty-search-selected");
    target.addClass("specialty-search-selected");
  }
});
