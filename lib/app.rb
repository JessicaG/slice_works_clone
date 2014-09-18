require 'sequel'
require_relative 'app/menu'

require 'dotenv'
Dotenv.load

class SliceWorksApp < Sinatra::Base
  attr_reader :db

  class << self
    attr_accessor :db
  end

  set :method_override, true
  set :root, 'lib/app'
  set :views, settings.root + '/views'
  set :public_folder, File.dirname(__FILE__) + '/public'
 
  use Rack::Session::Cookie, :key => 'rack.session',
                             :path => '/',
                             :secret => 'love'

  class << self
    attr_accessor :db
  end

  before do
    @db = self.class.db
  end

  get '/' do
    contacts = db[:contacts].select.to_a
    @capitol_hill = contacts.first
    @lodo         = contacts.last
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

  get '/log_in' do
    erb :log_in
  end

  post '/log_in' do
    authenticate!
    if session[:user] == "admin"
      redirect '/admin_dashboard'
    else
      redirect '/log_in'
    end
  end

  get '/admin/pages/edit_contacts' do
    number = db[:contacts].select
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
    @menu_item = {}
    login_helper(:edit)
  end

  get '/edit/:item_id' do |item_id|
    @menu_item = db["select * from gourmet_pizza_items where id=#{item_id}"].to_a.first
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
    erb :add_form
  end

  post '/add' do
    Menu.new.add(params) if authenticated?
    redirect '/admin_dashboard'
  end

  post '/contact' do
    require 'pony'
    Pony.subject_prefix("Slice Works: ")
    Pony.mail ({
      :subject => params[:subject],
      :from    => params[:mail],
      :body    => params[:message],
      :to      => 'lukeaiken@gmail.com',
      :via     => :sendmail
    })
    redirect '/'
  end

  get '/logout' do
    session[:user] = nil
    redirect '/goodbye'
  end

  ###Authentication Helpers###
  helpers do
    def authenticate!
      if params[:user] == "admin" && params[:password] == "ilovepizza"
        session[:user] = "admin"
      end
    end

    def authenticated?
      session[:user] == "admin" ? true : false
    end

    def login_helper(view, locals = {})
      if authenticated?
        erb :admin_dashboard
      else
        redirect '/log_in'
      end
    end
  end

  get '/:slug' do |slug|
    contacts = db[:contacts].select.to_a

    if slug == "lodo"
      number         = contacts.last
      erb :capitol_hill, :locals => {:number => number}
    elsif slug == 'capitol_hill'
      number = contacts.first
      erb :capitol_hill, :locals => {:number => number}
    elsif slug == 'locations'
      @capitol_hill = contacts.first
      @lodo         = contacts.last
      erb :locations
    else
    erb slug.to_sym
    end
  end
end
