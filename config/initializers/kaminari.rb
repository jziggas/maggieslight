# https://github.com/sferik/rails_admin/wiki/Troubleshoot
# Fix for conflict between will_paginate and rails_admin dependency kaminari
Kaminari.configure do |config|
  config.page_method_name = :per_page_kaminari
end