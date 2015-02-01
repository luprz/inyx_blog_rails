angular.module('inyxmater', ['post'])


.config(["$httpProvider", function(provider) {
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}]); // permite leer csrf token y añadirlo al ajax de angular para poder autenticar la seguridad de la aplicación
