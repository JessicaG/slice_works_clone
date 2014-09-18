require 'sequel'

class Menu
  attr_accessor :database

  def initialize
    db ||= Sequel.new
    @database ||= db[:slice_works]
  end

  def categories
    database.map { |x| x[:category] }.uniq
  end

  def menu_items(category)
    database.where(:category => category)
  end

  def item(item_id)
    database.where(:id => item_id).first
  end

  def gourmet_pizza
    gourmet_pizza = database.where(:menu => 'Gourmet Pizza')
    gourmet_pizza.map { |x| x[:category] }.uniq
  end

  def regular_menu
    regular = database.where(:menu => 'Regular')
    regular.map { |x| x[:category] }.uniq
  end

  def add(params)
    params = params[:params]
    database.insert(:menu => params[:menu],
                    :category => params[:category],
                    :name => params[:name],
                    :description => params[:description],
                    :price => params[:price])
  end

  def edit(id, params)
    database.where(:id => id).update(:name        => params[:menu_item][:name],
                                     :description => params[:menu_item][:description],
                                     :price       => params[:menu_item][:price])
  end

  def delete(id)
    database.where(:id => id).delete
  end
end
