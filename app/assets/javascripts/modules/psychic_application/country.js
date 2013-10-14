Module("IHP.Pages.PsychicApplications.Country", function(Country) {
  "use strict";

  Country.fn.initialize = function(el) {
    this.form = el;

    this.country = this.form.find("#psychic_application_country");
    this.state = this.form.find('select[name$="[state]"]');
    this.stateOutsideUSA = this.form.find('input[name$="[state]"]');

    this.handleCountry();
    this.addEventListeners();
  };

  Country.fn.addEventListeners = function() {
    this.country.on("change", this.handleCountry.bind(this));
  };

  Country.fn.handleCountry = function() {
    if (this.country.val() !== "United States") {
      this.state.attr("disabled", true).val("").hide();
      this.stateOutsideUSA.attr("disabled", null).show();
    } else {
      this.state.attr("disabled", null).show();
      this.stateOutsideUSA.attr("disabled", true).val("").hide();
    }
  };
});
