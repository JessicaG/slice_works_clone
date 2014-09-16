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

end
