/* Menu module */

MLA14.module('Menu', function(Menu, App) {

  App.addInitializer(function() {
    // Create the router and controller.
    Menu.router = new App.Routers.Menu.Router({
      controller: new App.Controllers.Menu.Controller()
    });
  });

});
