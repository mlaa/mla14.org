/* grunt-contrib-cssmin */

module.exports = {
  add_banner: {
    files: {
      'app/build/src/main.min.css': [
        'app/build/src/main.css'
      ]
    }
  }
};
