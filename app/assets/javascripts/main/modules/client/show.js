Module("IHP.Pages.ClientsShow", function(ClientsShow) {
  "use strict";

  ClientsShow.fn.initialize = function(el) {
    this.el = $(el);
    this.avatar = this.el.find(".avatar");
    this.form = this.el.find("form.upload-picture");
    this.fileUpload = this.el.find(".cloudinary-fileupload");

    this.params = {
      crop: 'thumb',
      format: 'png',
      gravity: 'faces:center',
      radius: 'max',
      width: 265,
      height: 265
    };

    this.addEventListeners();
    $("#client_phone").mask("999-999-9999");

    Module.run("IHP.Components.Scrollbar");
  };

  ClientsShow.fn.addEventListeners = function() {
    this.fileUpload.on("cloudinarydone", this.whenFileUploadDone.bind(this));
    this.form.on("ajax:success", this.whenFormSubmitted.bind(this));
    $(".favorite-left-arrow", this.el).on("click", this.paginateFavoritePsychicsLeft.bind(this));
    $(".favorite-right-arrow", this.el).on("click", this.paginateFavoritePsychicsRight.bind(this));
  };

  ClientsShow.fn.paginateFavoritePsychicsLeft = function() {
    var selectedPsychics = $(".favorite-psychics-container .psychic_group_selected").first();
    console.log("left");

    if (selectedPsychics.prev("section").length > 0) {
      selectedPsychics.removeClass("psychic_group_selected");
      selectedPsychics.prev("section").addClass("psychic_group_selected");
    }
  };

  ClientsShow.fn.paginateFavoritePsychicsRight = function() {
    var selectedPsychics = $(".favorite-psychics-container .psychic_group_selected");
    
    console.log("right");
    console.log(selectedPsychics);
    console.log(selectedPsychics.next("section"));
    if (selectedPsychics.next("section").length > 0) {
      selectedPsychics.removeClass("psychic_group_selected");
      selectedPsychics.next("section").addClass("psychic_group_selected");
    }
  };

  ClientsShow.fn.whenFileUploadDone = function(e, data) {
    this.publicId = data.result.public_id;
    this.form.submit();

    return true;
  };

  ClientsShow.fn.whenFormSubmitted = function(e, data, status, xhr) {
    this.avatar.html(
      $.cloudinary.image(this.publicId, this.params)
    );
  };
});
