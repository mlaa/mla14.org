/* grunt-manifest */

module.exports = {
  generate: {
    options: {
      basePath: 'app',
      network: ['*'],
      fallback: ['/ /'],
      verbose: true,
      timestamp: true
    },
    src: [
      'data/*.json',
      'img/maps/*.png'
    ],
    dest: 'app/build/cache.manifest'
  }
};
