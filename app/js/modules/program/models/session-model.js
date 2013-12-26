/* Session model */

MLA14.module('Models.Session', function(Session, App, Backbone) {

  Session.Model = Backbone.Model.extend({

    // Set defaults.
    defaults: {
      href: '',
      title: ''
    },

    formatTitle: function() {

      var title = this.get('title'),
          sequence = this.get('id'),
          isRegular = /^\d+A?$/.test(sequence);

      return {
        title: (isRegular) ? sequence + '. ' + title : title
      };

    }

  });

  Session.Collection = Backbone.Collection.extend({
    model: Session.Model
  });

});
