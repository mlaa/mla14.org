/* Info module */

MLA14.module('Info', function(Info, App) {

  App.addInitializer(function() {
    // Create the router and controller.
    Info.router = new App.Routers.Info.Router({
      controller: new App.Controllers.Info.Controller()
    });
  });

});
