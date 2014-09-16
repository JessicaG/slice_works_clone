$:.unshift File.expand_path("./../lib", __FILE__)

require 'bundler'
Bundler.require

require 'app'

SliceWorksApp.db = Sequel.connect(ENV['DATABASE_URL'] || 'postgres://localhost/slice_works')

database = Sequel.postgres('slice_works')
database.run "CREATE TABLE IF NOT EXISTS people (id serial primary key, name varchar(255))"
database.run "INSERT INTO people(name) VALUES('George')"

run SliceWorksApp
