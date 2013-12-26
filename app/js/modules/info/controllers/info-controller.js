/* Info controller */

MLA14.module('Controllers.Info', function(Info, App, Backbone, Marionette) {

  Info.Controller = Marionette.Controller.extend({

    // Generate section-level view.
    showInfo: function(resource) {

      // Activate menu tab.
      App.vent.trigger('menu:tab', 'info');

      // Append the view to the main region.
      App.Data.Promises.info.done(function(info) {

        if(info[resource]) {
          // Add view to content pane.
          App.Content.show(
            new App.Views.Info.ItemView({
              model: new App.Models.Info.Model(info[resource])
            })
          );
        } else {
          App.vent.trigger('error:notfound');
        }

      });

    }

  });

});
