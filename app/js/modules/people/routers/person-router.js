/* Person router */

MLA14.module('Routers.Person', function(Person, App, Backbone, Marionette) {

  Person.Router = Marionette.AppRouter.extend({

    initialize: function(options) {
      this.route(/^people\/([A-Z])$/, options.controller.showMenu);
      this.route(/^people\/([0-9]+)$/, options.controller.showPerson);
    }

  });

});
