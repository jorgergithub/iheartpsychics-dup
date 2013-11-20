Module("IHP.Pages.HomeCareers", function(HomeCareers) {
  "use strict";

  HomeCareers.fn.initialize = function(el) {
    this.el = $($(el).find(".careers aside"));
    this.tab = this.extractTab(document.location.toString()) || "main";
    this.addEventListeners();
    this.displayProperTab();
  };

  HomeCareers.fn.addEventListeners = function() {
    this.el.on("click", "li", this.changeSelection.bind(this));
  };

  HomeCareers.fn.changeSelection = function(e) {
    var link = this.extractTab($(e.target).attr("href"));

    $(".careers aside ul li.selected").removeClass("selected");
    $(".careers-link-" + link).addClass("selected");
    $(".careers article.selected").removeClass("selected");
    $(".careers article.careers-" + link).addClass("selected");

    location.hash = link;

    return false;
  };

  HomeCareers.fn.displayProperTab = function() {
    var liEl = $(".careers-link-" + this.tab);
    var articleEl = $(".careers-" + this.tab);

    liEl.addClass("selected");
    articleEl.addClass("selected");
  };

  HomeCareers.fn.extractTab = function(s) {
    var parts = s.split("#");
    if (parts.length > 1) {
      return parts[1];
    }
    else {
      return null;
    }
  };
});
