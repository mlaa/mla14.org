/* Search controller */

MLA14.module('Controllers.Search', function(Search, App, Backbone, Marionette) {

  // Element cache
  var $els = {
    html: $('html'),
    body: $('body'),
    search: $('#search'),
    terms:  $('#terms')
  },

  // Clean search terms.
  _cleanTerms = function(str) {
    return str.replace(/\+/g, ' ')
              .replace(/\s+/g, ' ')
              .replace(/^\s/, '')
              .replace(/\s$/, '');
  },

  // Send search in response to user request.
  _handler = function(e) {

    // Get search terms.
    var terms = _cleanTerms($els.terms.val()),
        termsURIFragment = encodeURIComponent(terms).replace(/%20/g, '+');

    // Blur search field.
    $els.terms.trigger('blur');

    // Push state.
    Backbone.history.navigate('search/' + termsURIFragment);

    // Send search.
    _fetchResults(termsURIFragment);

    // Prevent form submission.
    e.preventDefault();
    return false;

  },

  // Add class to body to prevent iOS keyboard yank on fixed position header.
  _onFocus = function() {
    $els.body.addClass('searchFocus');
    document.body.scrollTop = document.documentElement.scrollTop = 0;
  },

  // Remove class from body.
  _onBlur = function() {
    $els.body.removeClass('searchFocus');
  },

  // Retrieve search results via a spit 'n' glue API.
  _fetchResults = function(termsURIFragment) {

    // Fetch search results from MLA Program (via JSON module).
    // Check for a fruitful search. Get the sequence number of
    // each search result. If no results were found or an error
    // occurred, show an error message.

    // Load search terms.
    var searchTerms = termsURIFragment.replace(/\+/g, '%20'),
        cleanTerms = _cleanTerms(decodeURIComponent(termsURIFragment));

    // Activate menu tab.
    App.vent.trigger('menu:tab', 'program');

    // Show loading indicator.
    $els.html.addClass('loading');
    App.Content.reset();

    // Update search field.
    $els.terms.val('');

    // Fetch results.
    $.getJSON('/program/program_search?output=json&keyword=' + searchTerms)

      .done(function(data) {

        var ok = data.hasOwnProperty('results');

        // Hide loading indicator.
        $els.html.removeClass('loading');

        if(ok) {

          if(data.results.length) {

            // Extract sequence numbers from search results.
            var searchResults = _.map(data.results, function(result) {
              /* jshint camelcase: false */
              return result.sequence_number;
            }),

            // Create a header for the search results.
            searchHeader = {
              name: 'Search: ' + cleanTerms,
              sessions: searchResults
            };

            // Pass the rest of the work on the program module.
            App.vent.trigger('program:showGroup', searchHeader);

          } else {
            App.vent.trigger('error:empty', [{type:'head', title:cleanTerms}]);
          }

        } else {
          App.vent.trigger('error:unknown');
        }

      })
      .error(function() {
        $els.html.removeClass('loading');
        App.vent.trigger('error:unknown');
      });

  };

  // Bind to UI elements.
  $els.search.on('submit', _handler);
  $els.terms.on('focus', _onFocus);
  $els.terms.on('blur', _onBlur);

  Search.Controller = Marionette.Controller.extend({
    fetchResults: _fetchResults
  });

});
