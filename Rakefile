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

  desc "drop the database, re-create it, migrate and seed"
  task :reset do
    require "sequel"
    Rake::Task["db:load_env"].invoke
    psql = Sequel.connect(ENV["POSTGRES_URL"])
    puts "dropping database"
    psql << "drop database slice_works;"
    puts "creating database"
    psql << "create database slice_works;"
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:seed"].invoke
  end
end

desc "makeshift console"
task :console do
  require "pry"
  require "sequel"
  Rake::Task["db:load_env"].invoke
  db = Sequel.connect(ENV["DATABASE_URL"])
  binding.pry
end
