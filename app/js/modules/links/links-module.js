/* Link handler module */

MLA14.module('Links', function(Links, App, Backbone, Marionette, $) {

  // Listen for internal links when pushState is enabled.
  $('body').on('click', 'a', function(e) {

    if(Backbone.history.options && Backbone.history.options.pushState) {

      // Only act on internal links.
      var href = $(this).attr('href');

      if(href && href.charAt(0) === '#') {

        // Disable link and route manually.
        e.preventDefault();
        Backbone.history.navigate(href.substring(1), true);

      }

    }

  });

});
