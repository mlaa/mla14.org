/* Grunt task aliases */

module.exports = function(grunt) {

  grunt.registerTask(
    'default',
    [
      'jst',
      'concat:app',
      'jshint:app',
      'clean:app',
      'uglify:app',
      'string-replace:fix',
      'imageEmbed',
      'cssmin',
      'staticinline',
      'manifest'
    ]
  );

  grunt.registerTask('setup', ['components']);
  grunt.registerTask('components', ['concat:components']);
  grunt.registerTask('dev', ['default', 'connect', 'watch']);
  grunt.registerTask('deploy', ['default', 's3:staging', 'invalidate_cloudfront:staging']);
  grunt.registerTask('deploy-live', ['s3:live', 'invalidate_cloudfront:live']);

};
