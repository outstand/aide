# Aide

Glue between consul and your rails app.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'aide'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aide

## Development

- `desk go`
- `dev build --pull aide`
- `rspec specs` to run specs
- Set the application path in the volumes section in `compose.yml`.

To release a new version:
- Update the version number in `version.rb` and commit the result.
- `dev build --pull aide`
- `release_gem`
