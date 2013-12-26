/* Info router */

MLA14.module('Routers.Info', function(Info, App, Backbone, Marionette) {

  Info.Router = Marionette.AppRouter.extend({

    initialize: function(options) {
      this.route(/^info\/(.+)$/, options.controller.showInfo);
    }

  });

});
