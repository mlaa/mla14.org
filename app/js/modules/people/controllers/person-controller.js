/* Person controller */

MLA14.module('Controllers.Person', function(Person, App, Backbone, Marionette) {

  Person.Controller = Marionette.Controller.extend({

    // Generate section-level view.
    showMenu: function(category) {

      // Activate menu tab.
      App.vent.trigger('menu:tab', 'people');

      // Append the views to the main region.
      App.Data.Promises.people.done(function(people) {

        // Filter data to find the people that match the passed category.
        var filteredPeople = _.filter(people, function(person) {
          return person.cat.indexOf(category) !== -1;
        });

        filteredPeople.unshift({
          type: 'head',
          title: category
        });

        if(filteredPeople.length > 1) {
          // Add views to content pane.
          App.Content.show(
            new App.Views.Person.CollectionView({
              collection: new App.Models.Person.Collection(filteredPeople)
            })
          );
        } else {
          App.vent.trigger('error:empty', filteredPeople);
        }

      });

    },

    // Generate person-level view.
    showPerson: function(id) {

      // Activate menu tab.
      App.vent.trigger('menu:tab', 'people');

      // Append the views to the main region.
      App.Data.Promises.people.done(function(people) {

        // Find the person that matches the passed ID.
        var thePerson = _.find(people, function(person) {
          return person.id === id;
        });

        if(thePerson) {
          // Pass the rest of the work on the program module.
          App.vent.trigger('program:showGroup', thePerson);
        } else {
          App.vent.trigger('error:notfound', 'person');
        }

      });

    }

  });

});
