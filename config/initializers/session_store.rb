# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_liveliness_session',
  :secret      => 'c7cc3b17e12418a64b2eddebb99d38d25bb2b9497af1c788ba771c52d3850891a3f95a71ff5ee68ea766665e5b14f652a3dc3f33657b43192d5363fc839517cd'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
