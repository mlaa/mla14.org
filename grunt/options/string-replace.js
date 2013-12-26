/* grunt-string-replace */

// Address Uglify's inability to drop paths from source map URLs.

module.exports = {
  fix: {
    files: {
      'app/build/src/app.min.map': 'app/build/src/app.min.map'
    },
    options: {
      replacements: [{
        pattern: '"file":"app/build/src/app.min.js"',
        replacement: '"file":"app.min.js"'
      }]
    }
  }
};
