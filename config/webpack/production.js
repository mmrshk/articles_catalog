process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./environment')

environment.loaders.append('sass-loader', {
  use: [
    {
      loader: 'sass-loader',
    },
  ],
})

module.exports = environment.toWebpackConfig()
