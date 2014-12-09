## Empleoyees

Es un Engine que proporciona un blog integrado a inyxmater admin

## Caracteristicas

- Blog
- Configuración para personalización

## Requerimientos

* Ruby >= 1.9.3
* Rails >= 3.0.0

## Instalación

Añadir la siguiente linea a su Gemfile

```ruby
gem 'inyx_blog_rails', path: '../inyx_blog_rails'
gem 'acts-as-taggable-on', '~> 3.4'
gem 'cocoon'
```

Ubicarse en la ruta del proyecto desde la terminal y ejecutar

```ruby
Bundle install
```

```ruby
rake inyx_blog_rails:install:migrations
rake acts_as_taggable_on_engine:install:migrations
rake db:migrate
```

añadir la siguiente linea a su manifesto javascript `application.js`

```ruby
//= require inyx_blog_rails/application
```

añadir la siguiente linea a su manifesto javascript `application.css`

```ruby
*= require inyx_blog_rails/application
```

añadir la siguiente ruta a su archivo routes.rb

```ruby
mount InyxBlogRails::Engine, :at => '', as: 'post'
```

Por ultimo ir al directorio `app/assets/javascript/` y abrir el archivo main.js y agregar 'post' y 'categoryPost' a la suigiente linea de codigo codigo, ejemplo:

```ruby
angular.module('inyxmater', ['user']) #por defecto

angular.module('inyxmater', ['user', 'post', 'categoryPost']) #debe quedar asi
```

## Configuración

Para agregar `config/initializers/blog.rb` y asi estabelecer los datos de configuración, debe ejecutar

```ruby
rake blog:copy_initializer
```
## Vistas

Para copiar las vistas en `app/views/inyx_blog_rails` y asi personalizarlas para adaptarlas a sus necesidades, debe ejecutar

```ruby
rake blog:copy_views
```