/* Menu views */

MLA14.module('Views.Menu', function(Menu, App, Backbone, Marionette, $, _, Templates) {

  Menu.ItemView = Backbone.Marionette.ItemView.extend({

    tagName: 'li',
    template: Templates['app/js/modules/menus/templates/menu-item.tmpl'],

    className: function() {
      return this.model.attributes.type || this.model.attributes.style || null;
    },

    serializeData: function() {
      return $.extend(
        this.model.toJSON(),
        this.model.getLinkAttributes()
      );
    },

    initialize: function() {

      // Swap in alternate template when needed.
      if(this.model.attributes.type) {
        this.template = Templates['app/js/modules/menus/templates/menu-head.tmpl'];
      }

      if(this.model.attributes.href) {
        this.template = Templates['app/js/modules/menus/templates/menu-item-external.tmpl'];
      }

    }

  });

  Menu.CollectionView = Backbone.Marionette.CollectionView.extend({

    itemView: Menu.ItemView,
    tagName: 'ul',
    className: 'list',

    events: {
      'click a': 'saveMenuState'
    },

    // When user leaves, save scroll position.
    saveMenuState: function() {
      App.vent.trigger('menu:saveMenuState');
    }

  });

  Menu.MapCollectionView = Backbone.Marionette.CollectionView.extend({

    itemView: Menu.ItemView,
    tagName: 'ul',
    className: 'list',

    events: {
      'click .head': 'loadParentMenu'
    },

    loadParentMenu: function(e) {
      e.preventDefault();
      App.vent.trigger('menu:showParent', 'maps');
    }

  });

}, JST);
