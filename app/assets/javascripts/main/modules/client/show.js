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
  };

  ClientsShow.fn.addEventListeners = function() {
    this.fileUpload.on("cloudinarydone", this.whenFileUploadDone.bind(this));
    this.form.on("ajax:success", this.whenFormSubmitted.bind(this));
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
