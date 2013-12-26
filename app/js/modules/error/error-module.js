/* Error module */

MLA14.module('Error', function(Error, App) {

  App.addInitializer(function() {
    // Create the router and controller.
    Error.router = new App.Routers.Error.Router({
      controller: App.Controllers.Error.Controller
    });
  });

});
