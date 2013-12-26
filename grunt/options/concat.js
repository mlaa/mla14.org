/* grunt-contrib-concat */

module.exports = {
  app: {
    options: {
      banner:
        '/*!\n' +
        ' * <%= pkg.name %> v<%= pkg.version %>\n' +
        ' * <%= pkg.author.name %>\n' +
        ' * License: <%= pkg.license %>\n' +
        ' */\n\n'
    },
    files: {
      'app/build/app.js': [
        'app/js/*/**/*.js',
        'app/js/main.js'
      ]
    }
  },
  components: {
    files: {
      'app/build/src/components.min.js': [
        'app/bower_components/jquery/jquery.min.js',
        'app/bower_components/underscore/underscore-min.js',
        'app/bower_components/backbone/backbone-min.js',
        'app/bower_components/backbone.marionette/lib/backbone.marionette.min.js'
      ]
    }
  }
};
