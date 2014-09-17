$:.unshift File.expand_path("./../lib", __FILE__)

require 'bundler'
Bundler.require

require 'app'

SliceWorksApp.db = Sequel.connect(ENV['DATABASE_URL'] || 'postgres://localhost/slice_works')

run SliceWorksApp
