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
    erb :home, layout: :home_layout
  end

  not_found do
    erb :error
  end

  get '/:location/menu/:menu_type' do
    erb params[:menu_type].to_sym
  end

  ###Editing Menu DB###

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

  ###Content Pages###

  get '/admin/pages/new' do
    @page = Page.new
    slim :new
  end

  post 'admin/pages' do
    page = Page.create(params[:page])
    redirect to("/pages/#{page.id}")
  end

  get '/pages/:id/edit' do
    @page = Page.find(params[:id])
    slim :edit
  end

  put '/pages/:id' do
    page = Page.find(params[:id])
    page.update_attributes(params[:page])
    redirect to("/pages/#{page.id}")
  end

  get '/pages/delete/:id' do
    @page = Page.find(params[:id])
    slim :delete
  end

  delete '/pages/:id' do
    Page.find(params[:id]).destroy
    redirect to('/pages')
  end

  get '/login' do
    haml :login
  end

  post '/login' do
    authenticate!
    if session[:user] == "admin"
      redirect '/admin_dashboard'
    else
      redirect '/login'
    end
  end

  get '/admin/pages/edit_contacts' do
    number = db[:contacts].select
    require 'pry'
    binding.pry
    @lodo_number = number.first
    # @number = "(303)&nbsp;993-8127"
    # login_helper(:edit_contacts)
    erb :edit_contacts
  end

  ###LogIn and CMS Functionality###

  get '/admin_dashboard' do
    login_helper(:admin_dashboard)
  end

  get '/edit_menu' do
    login_helper(:admin_menu)
  end

  get '/edit/:item_id' do |item_id|
    login_helper(:form, {item_id: item_id})
  end

  post '/edit/:item_id' do |item_id|
    Menu.new.edit(item_id, params) if authenticated?
    redirect '/admin_dashboard'
  end

  get '/delete/:item_id' do |item_id|
    Meunu.new.delete(item_id) if authenticated?
    redirect '/admin_dashboard'
  end

  get '/add_menu_item' do
    haml :add_form
  end

  post '/add' do
    Menu.new.add(params) if authenticated?
    redirect '/admin_dashboard'
  end

  post '/contact' do
    require 'pony'
    #Pony.mail(
    #  from: params[:name]  + "<" + params[:email] + ">",
    #  to: 'lukeaiken@gmail.com',
    #  subject: params[:subject],
    #  body: params[:message],
    #  port: '587',
    #  via: :smpt,

  end

  get '/logout' do
    session[:user] = nil
    redirect '/goodbye'
  end

  ###Authentication Helpers###
  helpers do
    def authenticate!
      if params[:user] == "admin" && params[:password] == "password"
        session[:user] = "admin"
      end
    end

    def authenticated?
      session[:user] == "admin" ? true : false
    end

    def login_helper(view, locals = {})
      if authenticated?
        haml view, locals: locals
      else
        redirect '/log_in'
      end
    end
  end

  get '/:slug' do |slug|
    if slug == "lodo"
      number = '(303) 297-3464'
      erb :capitol_hill, :locals => {:number => number}
    elsif slug == 'capitol_hill'
      number = '(303) 993-8127'
      erb :capitol_hill, :locals => {:number => number}
    else
    erb slug.to_sym
    end
  end

  # get '/admin/locations' do
  #   @locations = Sequel.get('locations')
  #   @locations = [{id: 1, name: 'Denver Location', address: '123'},
  #                 {id: 2, name: 'Littleton Location', address: '456'}]
  #   erb 'admin/locations'
  # end
  #
  # get '/admin/locations/:id/edit' do |id|
  #   @location = Sequel.get('location', id)
  #   erb 'admin/locations/edit'
  # end

  # post '/admin/locations/:id' do |id|
  #   @location = Sequal.get('location', id)
  #
  #   name = params[:name]
  #   address = params[:address]
  #
  #   Sequal.update('location', id, {name: name, address: address})
  # end
end
