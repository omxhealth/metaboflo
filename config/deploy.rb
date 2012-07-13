# This application is configured to use 3 different capistrano environments. You need to install the capistrano-ext gem
# to deploy to these environments:
#
# > gem install capistrano-ext
#
# You can then deploy to the different environments like so:
#
# > cap production deploy

set :stages, %w(einstein demo testing production)
require 'capistrano/ext/multistage'

