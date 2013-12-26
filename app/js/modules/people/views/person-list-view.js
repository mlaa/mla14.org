/* Person views */

MLA14.module('Views.Person', function(Person, App, Backbone, Marionette, $, _, Templates) {

  Person.ItemView = Backbone.Marionette.ItemView.extend({

    tagName: 'li',
    template: Templates['app/js/modules/people/templates/person.tmpl'],

    className: function() {
      return this.model.attributes.type || null;
    },

    initialize: function() {
      // Swap in alternate template when needed.
      if(this.model.attributes.type) {
        this.template = Templates['app/js/modules/people/templates/person-head.tmpl'];
      }
    }

  });

  Person.CollectionView = Backbone.Marionette.CollectionView.extend({

    itemView: Person.ItemView,
    tagName: 'ul',
    className: 'list people',

    events: {
      'click .head': 'loadParentMenu',
      'click a': 'saveScrollPosition'
    },

    loadParentMenu: function(e) {
      e.preventDefault();
      App.vent.trigger('menu:showParent', 'people');
    },

    // When user leaves, save scroll position.
    saveScrollPosition: function() {
      App.vent.trigger('menu:saveMenuState');
    }

  });

}, JST);
