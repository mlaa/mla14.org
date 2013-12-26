/* Person module */

MLA14.module('Person', function(Person, App) {

  App.addInitializer(function() {
    // Create the router and controller.
    Person.router = new App.Routers.Person.Router({
      controller: new App.Controllers.Person.Controller()
    });
  });

});
