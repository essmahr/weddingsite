require 'rubygems'
require 'sinatra/base'
require 'compass'
require 'haml'
require 'susy'
require 'csv'
require 'json'

class SinatraBootstrap < Sinatra::Base
  # require './helpers/render_partial'

  get '/' do
    @home = true
    haml :index
  end
  
  get '/registry' do
    require_relative 'doc/registry_items'
    haml :registry
  end

  get '/accommodation' do
    require_relative 'doc/accommodation_items'
    haml :accommodation
  end

  get '/location' do
    require_relative 'doc/accommodation_items'
    haml :location
  end

  get '/registry/claim/:id' do
    file = "doc/registry.csv"
    new_items = []
    i = 0
    @success = true

    CSV.foreach(file) do |row|
      new_items[i] = row
      if row[0] == params[:id]
        if row[2] == 'unclaimed'
          new_items[i][2] = 'claimed' 
        else
          @success = false
        end
      end
      i += 1
    end
    
    
    CSV.open(file, 'wb') do |csv|
      new_items.each do |row|
        csv << row
      end
    end
    
    halt 200, {success: @success, id_removed: params[:id]}.to_json
    
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
    haml :about
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
