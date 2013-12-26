/* Info view */

MLA14.module('Views.Info', function(Info, App, Backbone, Marionette, $, _, Templates) {

  Info.ItemView = Backbone.Marionette.ItemView.extend({

    tagName: 'div',
    className: 'info',
    template: Templates['app/js/modules/info/templates/info.tmpl'],

    events: {
      'click .text-head': 'loadParentMenu'
    },

    loadParentMenu: function() {
      App.vent.trigger('menu:showParent', 'info');
    }

  });

}, JST);
