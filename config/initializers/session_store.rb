# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_produktionskort_session',
  :secret      => 'ce7b005ca24b7feec51a6107b9be2b991dc4670840b0774680d98e7aafc2a239128842ffcc818ff92cdf0158b6034656474346de89dd7d5cc7cd69fcbf29540f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
