source 'https://rubygems.org'
ruby '2.0.0'
gem 'rails', '4.0.0'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'bootstrap-sass'
# gem 'bootstrap-sass-rails'
gem 'cancan'
gem 'devise'
gem 'figaro'
gem 'haml-rails'
gem 'rolify'
gem 'simple_form', '>= 3.0.0.rc'
gem "paperclip", :git => "git://github.com/thoughtbot/paperclip.git"
gem 'sorted', '~> 0.4.3'
gem 'will_paginate', '~> 3.0'
gem 'rmagick'
gem 'aws-sdk'
gem 'rails_admin' # check for rails 4 compatibility
gem 'validates_email_format_of', :git => 'git://github.com/alexdunae/validates_email_format_of.git'
gem 'phony_rails'
gem "safe_yaml"
gem "obscenity", git: "https://github.com/jziggas/obscenity.git"
gem "make_flaggable", git: "https://github.com/jziggas/make_flaggable"
group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :rbx]
  gem 'html2haml'
  gem 'quiet_assets'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'sqlite3'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'email_spec'
end

group :production do
  gem 'pg'
  gem "rails_12factor"
end