/* Main */

// Start the history listener.
MLA14.on('initialize:after', function() {
  Backbone.history.start({pushState: true});
});

// Start application.
MLA14.start();
