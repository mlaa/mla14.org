/* Search module */

MLA14.module('Search', function(Search, App) {

  App.addInitializer(function() {
    // Create the router and controller.
    Search.router = new App.Routers.Search.Router({
      controller: new App.Controllers.Search.Controller()
    });
  });

});
