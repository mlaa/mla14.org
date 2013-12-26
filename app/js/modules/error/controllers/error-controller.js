/* Error controller */

MLA14.module('Controllers.Error', function(Error, App) {

  var _emptyError = function(header) {

    var error = {
      message: 'Nothing matched your request. Please try again.'
    };

    // Show error.
    App.Content.show(
      new App.Views.Error.CollectionView({
        collection: new App.Models.Error.Collection(header.concat([error]))
      })
    );

  },

  _notFoundError = function(type) {

    var error = {
      message: 'The ' + type + ' you requested was not found.'
    };

    // Show error.
    App.Content.show(
      new App.Views.Error.CollectionView({
        collection: new App.Models.Error.Collection([error])
      })
    );

  },

  _unknownError = function() {

    var error = {
      message: 'An unexpected error occurred. Please try again later.'
    };

    // Show error.
    App.Content.show(
      new App.Views.Error.CollectionView({
        collection: new App.Models.Error.Collection([error])
      })
    );

  };

  Error.Controller = {
    handleError: function() {
      _notFoundError('resource');
    }
  };

  App.vent.bind('error:empty', _emptyError);
  App.vent.bind('error:notfound', _notFoundError);
  App.vent.bind('error:unknown', _unknownError);

});
