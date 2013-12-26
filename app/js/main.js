/* Main */

// Start the history listener.
MLA14.on('initialize:after', function() {
  Backbone.history.start({pushState: true});
});

// Start application.
MLA14.start();

// Links.
//$(document).on('click', 'a, #filter-status', linkHandler);
//config.els.status.on('click', filterButton);

// Search.
//config.els.search.on('submit', searchHandler);
//config.els.terms.on('focus', searchOnFocus);
//config.els.terms.on('blur', searchOnBlur);
