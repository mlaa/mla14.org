/* Menu */

MLA14.module('Models.Menu', function(Menu, App, Backbone) {

  Menu.Model = Backbone.Model.extend({

    // Set defaults.
    defaults: {
      href: '',
      title: ''
    },

    getLinkAttributes: function() {

      var href = this.get('href'),
          target = '';

      // Determine link type by examining path/protocol.
      if(href.substring(0, 4) === 'http' || href.substring(0, 1) === '/') {
        target = ' target="_blank"';
      } else {
        href = '#' + href;
      }

      return {
        href: href,
        target: target
      };

    },

    formatTitle: function() {

      var title = this.get('title'),
          sequence = this.get('seq'),
          isRegular = /^\d+$/.test(sequence);

      return {
        title: (isRegular) ? sequence + '. ' + title : title
      };

    }

  });

  Menu.Collection = Backbone.Collection.extend({
    model: Menu.Model
  });

});
