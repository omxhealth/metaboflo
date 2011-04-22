# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_metaboflo_session',
  :secret      => '8af867d1fd11a5fd806025663b52f3e6cf1e7971f29835dd27f093550993c5831793771274d1aae21e3341ee60de63273d2aa71a3ea25d671aebe5117cf3fdf4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
