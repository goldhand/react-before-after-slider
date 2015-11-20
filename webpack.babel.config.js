import info from './package.json';
import path from 'path';


const config = () => {

  let buildFile = info.buildFile.split('/');

  const
    OUTPUT_FILE = buildFile.pop(),
    OUTPUT_FOLDER = buildFile.join('/');

  return {
    entry: {
      main: `./${info.main}`,
    },
    output: {
      path: path.resolve(__dirname, OUTPUT_FOLDER),
      publicPath: info.staticURL,
      filename: OUTPUT_FILE,
    },
    module: {
      loaders: [
        {
          test: /\.js$/,
          loader: 'babel-loader',
          exclude: /node_modules/,
          query: {
            presets: ['es2015', 'stage-0', 'react'],
          },
        },
        {test: /\.less$/, loader: 'style-loader!css-loader!less-loader'},
        {test: /\.css$/, loader: 'style-loader!css-loader'},
        {test: /\.(png|jpg|gif)$/, loader: 'url-loader?limit=8192'},  // inline base64 URLs <=8k
      ],
    },
  };
};

module.exports = config;
