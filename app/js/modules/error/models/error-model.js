/* Error */

MLA14.module('Models.Error', function(Error, App, Backbone) {

  Error.Model = Backbone.Model.extend({});

  Error.Collection = Backbone.Collection.extend({
    model: Error.Model
  });

});
