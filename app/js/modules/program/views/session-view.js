/* Session views */

MLA14.module('Views.Session', function(Session, App, Backbone, Marionette, $, _, Templates) {

  Session.ItemView = Backbone.Marionette.ItemView.extend({

    tagName: 'li',
    template: Templates['app/js/modules/program/templates/session.tmpl'],

    className: function() {
      return this.model.attributes.type || null;
    },

    serializeData: function() {
      return $.extend(
        this.model.toJSON(),
        this.model.formatTitle()
      );
    },

    initialize: function() {
      // Swap in alternate template when needed.
      if(this.model.attributes.type) {
        this.template = Templates['app/js/modules/program/templates/session-head.tmpl'];
      }
    }

  });

  Session.CollectionView = Backbone.Marionette.CollectionView.extend({

    itemView: Session.ItemView,
    tagName: 'ul',
    className: 'program list',

    events: {
      'click .head': 'loadParentMenu',
      'click .filter-head': 'editFilters',
      'click .subhead': 'toggleSessions',
      'click a': 'saveMenuState'
    },

    loadParentMenu: function(e) {
      e.preventDefault();
      App.vent.trigger('menu:showParent', '');
    },

    editFilters: function(e) {
      e.preventDefault();
      App.vent.trigger('program:editFilters', this.collection.models[0].get('cat'));
    },

    toggleSessions: function(e) {

      // Offset height depends on support for position:sticky.
      var offsetHeight = document.body.scrollTop,
          headerHeight = ($(e.target).css('position').indexOf('sticky') !== -1) ? 99 : 66, targetOffset;

      // Prevent default link action (select-y).
      e.preventDefault();

      // Toggle sessions.
      App.Content.$el.toggleClass('collapsed');

      // Get offset of clicked subhead.
      targetOffset = e.target.getBoundingClientRect();

      // Scroll to the clicked subhead.
      document.body.scrollTop = targetOffset.top + offsetHeight - headerHeight;

    },

    // When user leaves, save scroll position.
    saveMenuState: function() {
      App.vent.trigger('menu:saveMenuState');
    }

  });

}, JST);
