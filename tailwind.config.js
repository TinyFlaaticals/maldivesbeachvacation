module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
  ],
  theme: {
    extend: {
      colors: {
        primary: "#27AAE1",
      },
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
}
