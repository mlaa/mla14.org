/* Menu router */

MLA14.module('Routers.Menu', function(Menu, App, Backbone, Marionette) {

  Menu.Router = Marionette.AppRouter.extend({

    initialize: function(options) {

      // Routes added on initializer are in reverse priority order.

      // Menu routes
      this.route(/^(program|people|maps|info)\/?$/, options.controller.showMenu);
      this.route(/^maps\/(.+)$/, options.controller.showMaps);
      this.route(/^$/, options.controller.showMenu);

    }

  });

});
