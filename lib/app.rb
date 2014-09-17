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

  get '/:location/menu/:menu_type' do
    erb params[:menu_type].to_sym 
  end


  get '/:slug' do |slug|
    if slug == "lodo"
      number = '(303 297-3464)'
      erb :capitol_hill, :locals => {:number => number}
    elsif slug == 'capitol_hill'
      number = '(303) 993-8127'
      erb :capitol_hill, :locals => {:number => number}
    else
    erb slug.to_sym
    end
  end
end
