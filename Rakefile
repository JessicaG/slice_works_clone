require 'rake/testtask'

namespace :db do
  desc "load environment variables"
  task :load_env do
      require 'dotenv'
      Dotenv.load
  end

  desc "create database"
  task :create do
    require "sequel"
    Rake::Task["db:load_env"].invoke
    db = Sequel.connect(ENV["DATABASE_URL"])
    db << "create database slice_works;"
  end

  desc "run migrations"
  task :migrate, [:version] do |t, args|
    require "sequel"
    Sequel.extension :migration
    Rake::Task["db:load_env"].invoke
    db = Sequel.connect(ENV["DATABASE_URL"])
    if args[:version]
      `sequel -m db/migrations -M 0 #{ENV["DATABASE_URL"]}` if args[:version] == "0"
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, "db/migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(db, "db/migrations")
    end
  end

  desc "seed database"
  task :seed do
    Rake::Task["db:load_env"].invoke
    require_relative "./db/seeds"
  end
end

