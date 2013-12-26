/* Filter controller */

MLA14.module('Controllers.Filter', function(Filter, App, Backbone, Marionette, $, _) {

  Filter.Controller = {

    showFilters: function(filters) {

      var selectedFilters = (filters) ? filters.split(',') : [],

      // Loop through data and "activate" selected filters
      myFilterData = _.map(App.Data.Filter.Data, function(filterDatum) {
        if(selectedFilters.indexOf(filterDatum.href) !== -1) {
          filterDatum.active = 'active';
        } else {
          filterDatum.active = '';
        }
        return filterDatum;
      });

      // Activate menu tab.
      App.vent.trigger('menu:tab', 'program');

      // Show filters menu.
      App.Content.show(
        new App.Views.Filter.CollectionView({
          collection: new App.Models.Filter.Collection(myFilterData)
        })
      );

    }

  };

});
