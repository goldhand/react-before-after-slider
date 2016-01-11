require('babel-core/register');
if (global.Promise == null) {
  // so this works with 0.1x versions for node
  require('es6-promise').polyfill();
}
module.exports = require('./webpack.babel.config')();
