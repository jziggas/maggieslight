Rolify.configure do |config|
  # By default ORM adapter is ActiveRecord. uncomment to use mongoid
  # config.use_mongoid

  # Dynamic shortcuts for User class (user.is_admin? like methods). Default is: false
  # Enable this feature _after_ running rake db:migrate as it relies on the roles table

  # This was causing errors with RAILS_ENV=production rake assets:precompile
  # Try commenting this line out during precompile if errors occur, and then uncommenting before commit
  config.use_dynamic_shortcuts
end