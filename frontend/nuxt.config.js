
export default {
  mode: 'spa',
  subdirectory: '/',
  server: {
    host: '0.0.0.0',
    port: '8080'
  },
  /*
  ** Headers of the page
  */
  head: {
    title: 'Multikart Ecommerce | Vuejs shopping theme',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: process.env.npm_package_description || '' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/multikartvue/favicon.png' },
      { rel: 'stylesheet', href: 'https://fonts.googleapis.com/css?family=Lato:300,400,700,900' }
    ],
    script: [
      { src: 'https://checkout.stripe.com/checkout.js'}
    ]
  },

  router: {
    base: '/'
  },
  /*
  ** Customize the progress-bar color
  */
  loading: { color: '#ff4c3b', throttle: 200, height: '3px', css: true },
  /*
  ** Global CSS
  */
  css: [
    '@/assets/scss/app.scss',
    'swiper/dist/css/swiper.css'
  ],
  /*
  ** Plugins to load before mounting the App
  */
  plugins: [
     { src: '~/plugins/plugin.js', ssr:false },
     { src: '~/plugins/localStorage.js', ssr:false },
  ],
  /*
  ** Nuxt.js modules
  */
  modules: [
    // Doc: https://axios.nuxtjs.org/usage
    'bootstrap-vue/nuxt',
    '@nuxtjs/axios',
    'vue-scrollto/nuxt',
    '@nuxtjs/proxy'
  ],
  /*
  ** Axios module configuration
  ** See https://axios.nuxtjs.org/options
  */
  axios: {
    proxy: true,
  },
  proxy: {
    '/api': {
      target: 'http://backend:3000',
      pathRewrite: {
        '^/api': '/api'
      }
    },
  },
  generate: {
    fallback: true
  },
  /*
  ** Build configuration
  */
  build: {
    transpile: [
      "vee-validate/dist/rules"
    ],
    /*
    ** You can extend webpack config here
    */
    extend(config, ctx) {
    }
  }
}
