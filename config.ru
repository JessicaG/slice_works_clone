$:.unshift File.expand_path("./../lib", __FILE__)

require 'bundler'
Bundler.require

require 'app'

if ENV['DATABASE_URL']
  puts "**** USING #{ENV['DATABASE_URL']} ****"
  SliceWorksApp.db = Sequel.connect(ENV['DATABASE_URL'])
else
  puts "**** USING localhost ****"
  SliceWorksApp.db = Sequel.connect('postgres://localhost/slice_works')
end

# database = Sequel.postgres('slice_works')
database = SliceWorksApp.db
database.run "CREATE TABLE IF NOT EXISTS people (id serial primary key, name varchar(255))"
database.run "INSERT INTO people(name) VALUES('George')"

run SliceWorksApp
