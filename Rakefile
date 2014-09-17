require 'rake/testtask'

#Rake::TestTask.new do |t|
#  t.libs.push "lib"
#  t.test_files = FileList['test/*_test.rb']
#  t.verbose = true
#end
#

namespace :db do
  task :load_env do
      require 'dotenv'
      Dotenv.load
  end

  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    require "sequel"
    Sequel.extension :migration
    Rake::Task["db:load_env"].invoke
    db = Sequel.connect(ENV["DATABASE_URL"])
    if args[:version]
      if args[:version] == "0"
        puts "here"
        `sequel -m db/migrations -M 0 #{ENV["DATABASE_URL"]}`
      end
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, "db/migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(db, "db/migrations")
    end
  end
end

