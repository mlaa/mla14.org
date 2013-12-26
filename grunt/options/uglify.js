/* grunt-contrib-uglify */

module.exports = {
  app: {
    options: {
      // Cannot use banner with source map (grunt-contrib-uglify #22).
      // banner: '/*! <%= pkg.name %> v<%= pkg.version %> */\n',
      preserveComments: 'some',
      sourceMap: 'app/build/src/app.min.map',
      sourceMappingURL: 'app.min.map',
      sourceMapRoot: '/',
      sourceMapPrefix: 1
    },
    files: {
      'app/build/src/app.min.js': [
        'app/build/src/compiled-templates.js',
        'app/js/*/**/*.js',
        'app/js/main.js'
      ]
    }
  }
};
