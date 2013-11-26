$(document).ready(function() {
  var body = $("body");
  var page = body.data("page");

  Module.run("IHP.Components.PsychicCard", [body]);
  Module.run("IHP.Components.SignIn", [body]);

  if (page) {
    Module.run("IHP.Pages." + page, [body]);
  }
});
