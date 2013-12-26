/* Error view */

MLA14.module('Views.Error', function(Error, App, Backbone, Marionette, $, _, Templates) {

  Error.ItemView = Backbone.Marionette.ItemView.extend({

    tagName: 'li',
    template: Templates['app/js/modules/error/templates/error.tmpl'],

    className: function() {
      return this.model.attributes.type || this.model.attributes.style || null;
    },

    initialize: function() {
      // Swap in alternate template when needed.
      if(this.model.attributes.type) {
        this.template = Templates['app/js/modules/error/templates/error-head.tmpl'];
      }
    }

  });

  Error.CollectionView = Backbone.Marionette.CollectionView.extend({

    itemView: Error.ItemView,
    tagName: 'ul',
    className: 'error list',

    events: {
      'click .filter-head': 'editFilters'
    },

    editFilters: function(e) {
      e.preventDefault();
      Backbone.history.navigate('filter', true);
    }


  });

}, JST);
