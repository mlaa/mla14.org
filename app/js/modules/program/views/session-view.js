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

      // Prevent default link action (select-y).
      e.preventDefault();

      // Toggle sessions.
      if(App.Content.$el.hasClass('collapsed')) {

        // Get current scroll position.
        var offsetHeight = document.body.scrollTop || document.documentElement.scrollTop || 0,
            headerHeight, targetOffset;

        App.Content.$el.removeClass('collapsed');

        // Get offset of clicked subhead.
        targetOffset = e.target.getBoundingClientRect();

        // Offset height depends on support for position:sticky.
        headerHeight = ($(e.target).css('position').indexOf('sticky') !== -1) ? 99 : 66;

        // Scroll to the clicked subhead.
        document.body.scrollTop = document.documentElement.scrollTop = Math.max(targetOffset.top + offsetHeight - headerHeight, 0);

      } else {
        App.Content.$el.addClass('collapsed');
        document.body.scrollTop = document.documentElement.scrollTop = 0;
      }

    },

    // When user leaves, save scroll position.
    saveMenuState: function() {
      App.vent.trigger('menu:saveMenuState');
    }

  });

}, JST);
