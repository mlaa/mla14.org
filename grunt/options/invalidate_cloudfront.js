/* grunt-invalidate-cloudfront */

module.exports = {
  options: {
    key: '<%= aws.accessKeyId %>',
    secret: '<%= aws.secretAccessKey %>'
  },
  staging: {
    options: {
      distribution: 'E3PYT2VG5KYX14'
    },
    files: [
      {
        expand: true,
        cwd: 'app/',
        src: ['data/*.json'],
        filter: 'isFile',
        dest: ''
      },
      {
        expand: true,
        cwd: 'app/build/',
        src: [
          'index.html',
          'cache.manifest',
          'src/main.min.css',
          'src/app.min.js'
        ],
        filter: 'isFile',
        dest: ''
      }
    ]
  },
  live: {
    options: {
      distribution: 'E1NHITB9VQPQRG'
    },
    files: [
      {
        expand: true,
        cwd: 'app/',
        src: ['data/*.json'],
        filter: 'isFile',
        dest: ''
      },
      {
        expand: true,
        cwd: 'app/build/',
        src: [
          'index.html',
          'cache.manifest',
          'src/main.min.css',
          'src/app.min.js'
        ],
        filter: 'isFile',
        dest: ''
      }
    ]
  }
}
