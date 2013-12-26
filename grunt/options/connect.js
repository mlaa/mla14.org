/* grunt-contrib-connect */

module.exports = {
  server: {
    options: {
      base: [
        'app/',
        'app/build/'
      ],
      livereload: true,
      open: true,
      port: 8000
    }
  }
};
