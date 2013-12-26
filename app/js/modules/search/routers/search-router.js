/* Search router */

MLA14.module('Routers.Search', function(Search, App, Backbone, Marionette) {

  Search.Router = Marionette.AppRouter.extend({

    initialize: function(options) {
      this.route(/^search\/(.+)$/, options.controller.fetchResults);
    }

  });

});
