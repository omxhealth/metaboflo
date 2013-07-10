source 'http://rubygems.org'

# Core gems:
gem 'rails', '3.2.8'
gem 'thin', '1.3.1'
gem 'sqlite3'
gem 'roo'

# Gems used only for assets and not required in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'execjs'
  gem 'therubyracer', :require => 'v8', :platform => :ruby
  gem 'jquery-rails'
  gem 'jquery-ui-rails'
  gem 'jquery-ui-themes'
  gem 'highcharts-rails'
  gem 'jquery-tablesorter'
  gem 'yui-rails'
  gem 'jstree-rails', :git => 'git://github.com/tristanm/jstree-rails.git'
  gem 'jquery-cookie-rails'
end

group :production do
  gem 'execjs'
  gem 'therubyracer', :require => 'v8', :platform => :ruby
end

# Testing gems
group :test do
  gem 'shoulda'
  gem 'minitest'
  gem 'turn'
end

group :development do
  gem 'quiet_assets' # Don't show full asset pipeline logging in dev
end

# Deploy with Capistrano
#gem 'capistrano'
#gem 'capistrano-ext'

# Extra gems:
gem 'country-select'
gem 'devise'
gem 'paperclip'
gem 'meta_search'
gem 'will_paginate'
gem 'rabl'
