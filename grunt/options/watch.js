/* grunt-contrib-watch */

module.exports = {
  html: {
    options: {
      livereload: true
    },
    tasks: [
      'default'
    ],
    files: [
      'app/html/**/*.html',
      'app/data/*.html'
    ]
  },
  javascript: {
    options: {
      livereload: true
    },
    tasks: [
      'default'
    ],
    files: [
      'app/js/**/*.js'
    ]
  },
  css: {
    options: {
      livereload: true
    },
    tasks: [
      'default'
    ],
    files: [
      'app/css/*.css'
    ]
  }
};
