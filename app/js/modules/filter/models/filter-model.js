/* Filter */

MLA14.module('Models.Filter', function(Filter, App, Backbone) {

  Filter.Model = Backbone.Model.extend({

    // Set defaults.
    defaults: {
      active: ''
    }

  });

  Filter.Collection = Backbone.Collection.extend({
    model: Filter.Model
  });

});
