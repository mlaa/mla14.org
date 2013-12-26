/* Error router */

MLA14.module('Routers.Error', function(Error, App, Backbone, Marionette) {

  Error.Router = Marionette.AppRouter.extend({
    appRoutes: {
      '*error': 'handleError'
    }
  });

});
