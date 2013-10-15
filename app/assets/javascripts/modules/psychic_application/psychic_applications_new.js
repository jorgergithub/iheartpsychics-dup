Module("IHP.Pages.PsychicApplicationsNew", function(PsychicApplication) {
  "use strict";

  PsychicApplication.fn.initialize = function(el) {
    Emitter.extend(this);

    // element
    this.el = $(el);

    // psychic application form
    this.form = $(el).find("form");

    // sub components
    this.country = IHP.Pages.PsychicApplications.Country(this.form);
  };
});