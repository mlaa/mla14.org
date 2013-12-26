/* Session detail model */

MLA14.module('Models.SessionDetail', function(SessionDetail, App, Backbone) {

  SessionDetail.Model = Backbone.Model.extend({

    getSessionProperties: function() {

      var sequence = this.get('id'),
          isRegular = /^\d+A?$/.test(sequence);

      return {
        header: (isRegular) ? 'Session ' + sequence : '',
        hashtag: (isRegular) ? 's' + sequence : ''
      };

    }

  });

});
