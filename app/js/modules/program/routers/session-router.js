/* Session router */

MLA14.module('Routers.Session', function(Session, App, Backbone, Marionette) {

  Session.Router = Marionette.AppRouter.extend({

    initialize: function(options) {
      this.route(/^([0-9A-Z]+)$/, options.controller.showSessionByID);
      this.route(/^program\/([a-z,]+)$/, options.controller.showSessionsByCategory);
    }

  });

});
