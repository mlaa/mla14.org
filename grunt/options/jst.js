/* grunt-contrib-jst */

module.exports = {
  templates: {
    files: {
      'app/build/src/compiled-templates.js': [
        'app/js/**/*.tmpl'
      ]
    }
  }
};
