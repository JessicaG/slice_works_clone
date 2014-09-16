require 'sequel'
require_relative './slice_works'

class SliceWorksApp < Sinatra::Base
  set :method_override, true
  set :root, 'lib/app'
  set :views, settings.root + '/views'
  set :public_folder, File.dirname(__FILE__) + '/public'


  Tilt.register Tilt::ERBTemplate, 'html.erb'

  get '/' do
    erb :home
  end

  not_found do
    erb :error
  end

  get '/menus' do
    erb :menus
  end

  get '/catering' do
    erb :catering
  end

  get '/locations' do
    erb :locations
  end

  get '/gift_cards' do
    erb :gift_cards
  end

  get '/contact_us' do
    erb :contact_us
  end

  get '/capitol_hill' do
    erb :capitol_hill
  end
end
