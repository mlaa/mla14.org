/* Person */

MLA14.module('Models.Person', function(Person, App, Backbone) {

  Person.Model = Backbone.Model.extend({});

  Person.Collection = Backbone.Collection.extend({
    model: Person.Model
  });

});
