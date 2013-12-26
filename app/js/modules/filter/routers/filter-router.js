/* Filter router */

MLA14.module('Routers.Filter', function(Filter, App, Backbone, Marionette) {

  Filter.Router = Marionette.AppRouter.extend({

    initialize: function(options) {
      this.route(/^filter$/, options.controller.showFilters);
      this.route(/^filter\/([a-z,]+)$/, options.controller.showFilters);
    }

  });

});
