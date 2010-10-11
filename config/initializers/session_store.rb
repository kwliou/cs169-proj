# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_cs169-proj_session',
  :secret      => 'e88f16a97f4a0fb8922475b60cb1c42bd1203613a2d8d0052715ea4d7e78b539da758d740250d34a94514cb42113394dca67903d3244f36ff7d9c4f84d14e5f7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
