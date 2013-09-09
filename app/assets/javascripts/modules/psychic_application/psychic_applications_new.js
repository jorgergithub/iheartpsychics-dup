Module("IHP.Pages.PsychicApplicationsNew", function(PsychicApplicationsNew) {
  "use strict";

  PsychicApplicationsNew.fn.initialize = function(el) {
    this.el = $(el);
    this.howDidYouHear = this.el.find("#psychic_application_how_did_you_hear");
    this.other = this.el.find("#other");
    this.addEventListeners();
  };

  PsychicApplicationsNew.fn.addEventListeners = function() {
    this.howDidYouHear.on("change", this.whenHowDidYouHearChanges.bind(this));
  };

  PsychicApplicationsNew.fn.whenHowDidYouHearChanges = function() {
    var val = this.howDidYouHear.find('option:selected').text();
    if (val == 'Other') {
      this.showOther();
    }
    else {
      this.hideOther();
    }
  };

  PsychicApplicationsNew.fn.showOther = function() {
    this.other.show();
    this.other.find("input").removeAttr("disabled");
    this.other.find("input").focus();
  };

  PsychicApplicationsNew.fn.hideOther = function() {
    this.other.find("input").attr("disabled", "disabled");
    this.other.hide();
  };
});
