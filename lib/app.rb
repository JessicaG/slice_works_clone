require 'pony'
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

  set :email_username, ENV['SENDGRID_USERNAME'] || ENV['LOCALHOST_USERNAME']
  set :email_password, ENV['SENDGRID_PASSWORD'] || ENV['LOCALHOST_PASSWORD']
  set :email_address, 'daz@gmail.com'
  set :email_service, ENV['EMAIL_SERVICE'] || 'gmail.com'
  set :email_domain, ENV['SENDGRID_DOMAIN'] || 'localhost.localdomain'

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
    menu_items = db[:menu_items].select.to_a
    @menu_items = menu_items.first
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

  get '/happy-hour/' do
    erb :happy_hour_menu
  end

  get '/catering/' do
    erb :catering_menu
  end

  get '/admin/pages/edit_contacts' do
    number = db[:contacts].select.to_a
    @lodo_number = number.last
    @capitol_hill_number = number.first
    login_helper(:edit_contacts)
  end

  ###LogIn and CMS Functionality###

  get '/admin_dashboard' do
    login_helper(:admin_dashboard)
  end

  get '/new' do
    @menu_item = {}
    login_helper(:edit)
  end

  get '/menu_items' do
    @menu_items = db[:gourmet_pizza_items].to_a
    login_helper(:menu_items)
  end

  get '/edit/:item_id' do |item_id|
    @menu_item = db["select * from gourmet_pizza_items where id='#{item_id}'"].to_a.first
    login_helper(:edit, {item_id: item_id})
  end

  post '/edit/:item_id' do |item_id|
    db.run("update gourmet_pizza_items set name='#{params[:name]}', description='#{params[:description]}', price='#{params[:price]}', by_slice='#{params[:by_slice]}' where id='#{item_id}'")
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
     Pony.mail(
      :from => params[:name] + "<" + params[:email] + ">",
      :to => settings.email_address,
      :subject => params[:name] + " has contacted you",
      :body => params[:message],
      :port => '587',
      :via => :smtp,
      :via_options => {
        :address              => 'smtp.' + settings.email_service,
        :port                 => '587',
        :enable_starttls_auto => true,
        :user_name            => settings.email_username,
        :password             => settings.email_password,
        :authentication       => :plain,
        :domain               => settings.email_domain
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
        erb view
      else
        redirect '/log_in'
      end
    end
  end

  post '/phone_number' do
    db.run("update contacts set number = '#{params[:lodo_number]}' where location = 'LODO'")
    db.run("update contacts set number = '#{params[:capitol_hill_number]}' where location = 'Capitol Hill'")
    redirect '/admin_dashboard'
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
      @capitol_hill = contacts.first
      @lodo         = contacts.last
    erb slug.to_sym
    end
  end
end
