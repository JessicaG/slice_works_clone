require 'sequel'
require_relative './slice_works'

#Sequel.postgres('slice_works')

class SliceWorksApp < Sinatra::Base
  attr_reader :db

  set :method_override, true
  set :root, 'lib/app'
  set :views, settings.root + '/views'
  set :public_folder, File.dirname(__FILE__) + '/public'

  Tilt.register Tilt::ERBTemplate, 'html.erb'

  enable :sessions

  class << self
    attr_accessor :db
  end

  before do
    @db = self.class.db
  end

  get '/' do
    people = db.fetch "select * from people"
    @person = people.to_a.first
    erb :home
  end

  not_found do
    erb :error
  end

end
