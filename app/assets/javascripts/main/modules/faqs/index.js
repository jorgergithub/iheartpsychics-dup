Module("IHP.Pages.FaqsIndex", function(FaqsIndex) {
  "use strict";

  FaqsIndex.fn.initialize = function(el) {
    this.el = $($(el).find("section.faqs aside"));

    this.tab = $("section.faqs").attr("data-selected-tab");
    this.tab = this.tab || this.extractTab(document.location.toString())
    this.tab = this.tab || this.extractTab($("section.faqs ul li:first").attr("href"));

    this.questionEls = $(".faq", el);

    this.selectedEntry = $(".faqs-entry:first");
    this.selectedEntry.addClass("active");

    this.addEventListeners();
    this.displayProperTab();
  };

  FaqsIndex.fn.addEventListeners = function() {
    this.el.on("click", "li", this.changeSelection.bind(this));
    this.questionEls.on("click", ".faqs-entry", this.changeQuestion.bind(this));
  };

  FaqsIndex.fn.changeQuestion = function(e) {
    var faqEntry = $(e.target);
    $(".faqs-entry.active").removeClass("active");
    faqEntry.closest("section").addClass("active");
  };

  FaqsIndex.fn.changeSelection = function(e) {
    var link = this.extractTab($(e.target).attr("href"));

    $("section.faqs aside ul li.selected").removeClass("selected");
    $(".faqs-link-" + link).addClass("selected");
    $("section.faqs article.selected").removeClass("selected");
    $("section.faqs article.faqs-" + link).addClass("selected");

    $(".faqs-entry.active").removeClass("active");
    $(".faqs-entry:visible:first").closest("section").addClass("active");

    location.hash = link;

    return false;
  };

  FaqsIndex.fn.displayProperTab = function() {
    var liEl = $(".faqs-link-" + this.tab);
    var articleEl = $(".faqs-" + this.tab);

    liEl.addClass("selected");
    articleEl.addClass("selected");
  };

  FaqsIndex.fn.extractTab = function(s) {
    var parts = s.split("#");
    if (parts.length > 1) {
      return parts[1];
    }
    else {
      return null;
    }
  };
});
