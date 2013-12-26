/* Session module */

MLA14.module('Session', function(Session, App) {

  App.addInitializer(function() {
    // Create the router and controller.
    Session.router = new App.Routers.Session.Router({
      controller: new App.Controllers.Session.Controller()
    });
  });

});
