/* Menu controller */

MLA14.module('Controllers.Menu', function(Menu, App, Backbone, Marionette) {

  // View cache
  var _viewCache = {},

  // Element cache
  $els = {
    body: $('body'),
    content: $('#content'),
    actions: $('#home-actions'),
    tabs: {
      all: $('#tabs li'),
      program: $('#program-tab'),
      filters: $('#program-tab'),
      people: $('#people-tab'),
      maps: $('#maps-tab'),
      info: $('#info-tab')
    }
  },

  // Active navigation tab.
  _activateTab = function(section) {

    // Test for home page.
    var isHome = (Backbone.history.fragment === '');

    // Scroll to top of the window.
    document.body.scrollTop = 0;

    // Remove "collapsed" class, if present.
    $els.content.removeClass('collapsed');

    // Show "skyline" expanded header on home page.
    $els.body.toggleClass('home', isHome);

    // Show actions on home page.
    $els.actions.toggle(isHome);

    // Add "here" class to show active tab.
    $els.tabs.all.removeClass('here');
    $els.tabs[section].addClass('here');

  },

  // Save menu state.
  _saveMenuState = function() {
    Menu.stateCache.push({
      fragment: Backbone.history.fragment,
      scrollPos: document.body.scrollTop || 0
    });
  },

  // Create the appearance of restoring the parent menu.
  _showParent = function(section) {

    // Get previous state.
    var state = Menu.stateCache.pop() || Menu.fallbackState;

    // Change URL.
    Backbone.history.navigate(state.fragment || section || '', true);

    // Set scroll position.
    document.body.scrollTop = state.scrollPos;

  },

  // Generate section-level view.
  _showMenu = function(section) {

    section = section || 'program';

    // Set menu tab.
    _activateTab(section);

    // Create the view if it doesn't exist in the cache.
    if(!_viewCache[section]) {
      _viewCache[section] = new App.Views.Menu.CollectionView({
        collection: new App.Models.Menu.Collection(App.Data.Menu.Data[section])
      });
    } else {
      // Delegate events since we are reusing views.
      _viewCache[section].delegateEvents();
    }

    // Append the views to the content region.
    App.Content.show(_viewCache[section]);

  },

  _updateInformation = function() {
    // Append the views to the main region.
    App.Data.Promises.updated.done(function(update) {
      App.Updated.show(
        new App.Views.Updated.ItemView({
          model: new Backbone.Model(update)
        })
      );
    });
  };

  Menu.Controller = Marionette.Controller.extend({

    showMenu: _showMenu,

    // Maps are just a big menu.
    showMaps: function(map) {

      // Set menu tab.
      _activateTab('maps');

      if(App.Data.Menu.Maps[map]) {
        // Append the views to the content region.
        App.Content.show(
          new App.Views.Menu.MapCollectionView({
            collection: new App.Models.Menu.Collection(App.Data.Menu.Maps[map])
          })
        );
      } else {
        App.vent.trigger('error:notfound');
      }

    }

  });

  // Menu state cache
  Menu.stateCache = [];

  // Fallback menu state
  Menu.fallbackState = {
    fragment: '',
    scrollPos: 0
  };

  // Bind to custom events.
  App.vent.bind('menu:tab', _activateTab);
  App.vent.bind('menu:showParent', _showParent);
  App.vent.bind('menu:saveMenuState', _saveMenuState);

  // Show last-updated date.
  _updateInformation();

});
