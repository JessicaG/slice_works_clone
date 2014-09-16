#require 'rake/testtask'
#
#task :load_env do
#  require 'dotenv'
#  Dotenv.load
#end
#
#Rake::TestTask.new do |t|
#  t.libs.push "lib"
#  t.test_files = FileList['test/*_test.rb']
#  t.verbose = true
#end
#
#desc 'run test migrations'
#task migrate_test: [:load_env] do
#  sh "sequel -m migrations #{ENV['TEST_DATABASE_URL']}"
#end
#
#desc 'run development migrations'
#task migrate_dev: [:load_env] do
#  sh "sequel -m migrations #{ENV['DATABASE_URL']}"
#end
