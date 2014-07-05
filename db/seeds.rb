# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
=begin
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name(role)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name
user.add_role :admin
=end
Role.find_or_create_by_name("admin")
Role.find_or_create_by_name("user")

require 'csv'

CSV.foreach("#{Rails.root}/active.csv", :encoding => 'windows-1251:utf-8') do |row|
  unless row[13] == "contact_email"
    user = User.find_or_create_by(
        :name => row[13].split('@')[0].split('.').join(' ').titleize,
        :email => row[13]
        ) do |created_user|
      created_user.password = row[17]
    end
  end
end

CSV.foreach("#{Rails.root}/active.csv", :encoding => 'windows-1251:utf-8') do |row|
  unless row[13] == "contact_email"
    user = User.find_by_email(row[13].downcase)
    user.care_receiver_profiles.find_or_create_by(
    :name =>            row[0],
    :birthdate =>        row[1],
    :gender =>           row[2],
    :disabilities =>     row[3],
    :hobbies =>          row[4],
    :services_needed =>  row[5],
    :misc =>             row[6],
    :hours_needed =>     row[7],
    :days_needed =>      row[8],
    :city =>             row[9],
    :county =>           row[10],
    :transportation =>   row[11],
    :contact_name =>     row[12],
    :contact_email =>    row[13],
    :contact_phone =>    row[14],
    :status =>           row[15]
    )
  end
end
