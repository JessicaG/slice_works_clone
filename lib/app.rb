require_relative './slice_works'

class SliceWorksApp < Sinatra::Base
  set :method_override, true
  set :root, 'lib/app'
  set :public_folder, 'public'
  set :views, settings.root + '/views'


  get '/' do
    # 'Eat. Drink. Relax'
    erb :home
  end

  not_found do
    erb :error
  end

end
