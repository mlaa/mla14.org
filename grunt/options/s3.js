/* grunt-aws */

module.exports = {
  options: {
    accessKeyId: '<%= aws.accessKeyId %>',
    secretAccessKey: '<%= aws.secretAccessKey %>',
    region: '<%= aws.region %>'
  },
  staging: {
    options: {
      bucket: 'staging.mla14.org'
    },
    files: [
      {
        cwd: 'app/build/',
        src: '**/*'
      },
      {
        cwd: 'app/html/',
        src: 'robots.txt'
      },
      {
        cwd: 'app/data/',
        src: '*',
        dest: 'data/'
      },
      {
        cwd: 'app/img/',
        src: '**/*',
        dest: 'img/'
      },
      {
        cwd: 'app/js/',
        src: '**/*.js',
        dest: 'js/'
      }
    ]
  },
  live: {
    options: {
      bucket: 'mla14.org'
    },
    files: [
      {
        cwd: 'app/build/',
        src: '**/*'
      },
      {
        cwd: 'app/data/',
        src: '*',
        dest: 'data/'
      },
      {
        cwd: 'app/img/',
        src: '**/*',
        dest: 'img/'
      },
      {
        cwd: 'app/js/',
        src: '**/*.js',
        dest: 'js/'
      }
    ]
  }
};
