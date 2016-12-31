source 'https://rubygems.org'
ruby '2.3.0'

gem 'bundler', '>= 1.8.4'
gem 'rails', '~> 4.2.0'
gem 'mysql2'
gem 'sass-rails', '~> 5.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', github: 'turbolinks/turbolinks-classic'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jquery-ui-themes'
gem 'jbuilder', '~> 2.0'
gem 'sass-rails', '~> 5.0'
gem 'highcharts-rails'
gem 'jquery-tablesorter'
gem 'yui-rails'
gem 'jquery-cookie-rails'
gem 'country-select'
gem 'devise'
gem 'paperclip'
gem 'ransack'
gem 'will_paginate'
gem 'rabl'
gem 'simple_form'
gem 'cocoon'
gem 'slim-rails'

source 'https://rails-assets.org' do
  gem 'rails-assets-jstree'
  gem 'rails-assets-bootstrap-sass'
end

group :production do
  gem 'execjs'
  gem 'therubyracer', require: 'v8'
end

# Testing gems
group :test do
  gem 'shoulda'
  gem 'test-unit'
end

group :development do
  gem 'quiet_assets' # Don't show full asset pipeline logging in dev
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and
  # get a debugger console
  gem 'byebug'
  # Access an IRB console on exception pages or by using
  # <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'minitest-rails'
end

group :development, :production do
  gem 'puma'
end

