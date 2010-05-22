# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rails_example_session',
  :secret      => 'fbd7f3fb0561c17b6b5435a37dc3bd86570dbb8d109c76d53715b1a6c43819ba80828aad01d5342a98b2ab939f0d51cca14d07fd1c919b6047d7471eb33a92eb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
