process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./environment')

environment.loaders.append('sass-loader', {
  test: /\.s[ac]ss$/i,
  use: [
    {
      loader: 'sass-loader',
    },
  ],
})

module.exports = environment.toWebpackConfig()
