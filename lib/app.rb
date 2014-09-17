require 'sequel'

class SliceWorksApp < Sinatra::Base
  attr_reader :db

  set :method_override, true
  set :root, 'lib/app'
  set :views, settings.root + '/views'
  set :public_folder, File.dirname(__FILE__) + '/public'

  enable :sessions

  class << self
    attr_accessor :db
  end

  before do
    @db = self.class.db
  end

  get '/' do
    people = db[:people].select
    @person = people.to_a.first
    erb :home
  end

  not_found do
    erb :error
  end

  # get '/:location/' do |location|
  #   if location == "lodo"
  #     number = '2223334444'
  #   else
  #     number = '5556667777'
  #   end
  #
  #   erb :location, :locals => {:number => number}
  # end
  #
  # get '/:location/menu/:menu_type' do
  #   erb params[:menu_type].to_sym # dine_in, :catering, :happy_hour
  # end
  #
  # get '/:location/menu/dine_in'

  get '/:slug' do |slug|
    erb slug.to_sym
  end
end
