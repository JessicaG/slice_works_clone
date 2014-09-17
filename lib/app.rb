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


  get '/admin' do
    @menu_items = db[:menu_items]
  end

  get '/admin/menu/edit/:id' do |id|
    db[:menu_items]
    db["SELECT * FROM menu_items WHERE id = #{id}"]
  end

  post '/admin/menu/edit/:id' do |id|
    db.run("UPDATE menu items SET name = #{params[:name]}, description = #{params[:description]}, price = #{params[:price]} WHERE id = #{id}")
  end

  get '/admin/locations' do
    @locations = Sequel.get('locations')
    @locations = [{id: 1, name: 'Denver Location', address: '123'},
                  {id: 2, name: 'Littleton Location', address: '456'}]
    erb 'admin/locations'
  end

  get '/admin/locations/:id/edit' do |id|
    @location = Sequel.get('location', id)
    erb 'admin/locations/edit'
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

  # post '/admin/locations/:id' do |id|
  #   @location = Sequal.get('location', id)
  #
  #   name = params[:name]
  #   address = params[:address]
  #
  #   Sequal.update('location', id, {name: name, address: address})
  # end
end
