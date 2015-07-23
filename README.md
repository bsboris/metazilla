# Metazilla

Simple gem to deal with titles and meta tags for Rails 3+.

## Installation

Add this line to your application's Gemfile:

    gem "metazilla", "~> 1.0"

And then execute:

    $ bundle

## Usage

### Title

`title "My page"` to set page title.

`title` to get page title.

`app_title "My app"` to set application title.

`app title` to get application title.

`full_title` generates full title (page and app title joined).

`title_tag` generates `<title>` tag with full title. Place this in your layout.

### Meta tags

`meta :description, "My app description"` to set meta tag.

`meta :description` to get meta tag.

`meta_tag :description` generates `<meta>` tag. Place this in your layout.

### I18n

Metazilla fully supports Rails built-in i18n engine.

Place your titles and meta tags in the en.yml file:

    en:
      app: My app
      meta:
        description: My app.
      posts:
        title: Posts
        index:
          title: Posts list
          meta:
            description: My posts list.

### Passing variables to translations

All defined instance variables passed to translations.

YAML:

    en:
      titles:
        users:
          show: User: %{user}

Model:

    class User < ActiveRecord::Base
      def to_s
        user.full_name
      end
    end

Controller:

    def show
      @user = User.find(params[:id])
    end

View:

    title # => User: John Doe


### Namespacing

Namespaced controllers/views are supported, so you can have separate set of titles for different parts of your application.

    en:
      app: My app
      admin:
        app: My admin panel

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
