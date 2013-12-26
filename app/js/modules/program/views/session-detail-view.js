/* Session detail view */

MLA14.module('Views.SessionDetail', function(SessionDetail, App, Backbone, Marionette, $, _, Templates) {

  SessionDetail.ItemView = Backbone.Marionette.ItemView.extend({

    tagName: 'div',
    className: 'session',
    template: Templates['app/js/modules/program/templates/session-detail.tmpl'],

    serializeData: function() {
      return $.extend(
        this.model.toJSON(),
        this.model.getSessionProperties()
      );
    },

    events: {
      'click .text-head': 'loadParentMenu'
    },

    loadParentMenu: function(e) {
      e.preventDefault();
      App.vent.trigger('menu:showParent', '');
    }

  });

}, JST);
