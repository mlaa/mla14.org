/* Filter module */

MLA14.module('Filter', function(Filter, App) {

  App.addInitializer(function() {
    // Create the router and controller.
    Filter.router = new App.Routers.Filter.Router({
      controller: App.Controllers.Filter.Controller
    });
  });

  // Get description of the current filters.
  Filter.GetFilterDescription = function(filters) {

    var filterDescription = 'Filters';

    if(filters.length) {
      filterDescription += ': ' + _.map(filters, function(filter) {
        return App.Data.Filter.Categories[filter];
      }).join(', ');
    }

    return filterDescription;

  };

});
