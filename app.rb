require 'rubygems'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/assetpack'
require 'compass'
require 'newrelic_rpm'
require 'haml'
require 'susy'
require 'csv'
require 'json'
require 'net/smtp'

require './config/environments'

class Post < ActiveRecord::Base
end

set :root, File.dirname(__FILE__)

register Sinatra::AssetPack

assets do
  js :app, '/app.js', [
    '/js/jquery.fancybox.pack.js',
    '/js/lazyload.js',
    '/js/application.js',      
  ]
  
  js_compression :jsmin
  
end  

get '/' do
  @home = true
  haml :index
end

get '/registry' do
  @slug = 'Registry'
  $claimed_items = []
  require_relative 'doc/registry_items'

  Post.all.each do |claimed_item|
    $claimed_items.push(claimed_item[:item_id])
  end
  
  haml :registry
  
end

get '/accommodation' do
  @slug = 'Accommodation'
  require_relative 'doc/accommodation_items'
  haml :accommodation
end

get '/location' do
  @slug = 'Location & Logistics'
  require_relative 'doc/accommodation_items'
  haml :location
end

get '/registry/claim/:id' do
  @success = false
  unless Post.exists?(item_id: params[:id])
    Post.create(item_id: params[:id])
    @success = true
  end
  halt 200, {success: @success, id_removed: params[:id]}.to_json
end


get '/registry/unclaim/:id' do
  if Post.exists?(item_id: params[:id])
    item = Post.find_by item_id: params[:id]
    "item id #{item.item_id} destroyed."
    item.destroy
  else
    "item id #{params[:id]} does not exist."
  end
end


=begin  
get '/registry/claim/:id' do
  CSV.foreach("doc/registry.csv") do |row|
    if row[0] == params[:id]
      if row[2] == 'claimed'
        puts 'already claimed.'
      else
        puts 'you claimed this!'
      end
    end
  end
  
  "All Done."
end
=end

get '/about' do
  @slug = 'About'
  haml :about
end