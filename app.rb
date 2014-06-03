require 'sinatra'
require 'json'
require 'data_mapper'
require 'dm-migrations'

DataMapper.setup(:default, 'sqlite:///tmp/test.db')

class Cake
  include DataMapper::Resource
  property :id,           Serial                      # An auto-increment integer key
  property :name,         String                      # A varchar type string, for short strings
  property :imageURL,     String, :length => 1024     # The URL to the image
  property :description,  String, :length => 1024     # The description of the cake
end

class Pie
  include DataMapper::Resource
  property :id,           Serial                      # An auto-increment integer key
  property :name,         String                      # A varchar type string, for short strings
  property :imageURL,     String, :length => 1024     # The URL to the image
  property :description,  String, :length => 1024     # The description of the pie
end  
DataMapper.finalize


get '/' do
  File.read('cakes.html')
end


get '/pastries.json' do
  content_type :json
  cakeArr = Cake.all
  pieArr = Pie.all
  arr = {"Cakes" => cakeArr, "Pies" => pieArr}
  arr.to_json
end


get '/cakes/:id' do
  content_type :json
  temp = Cake.get(params[:id])
  if (temp.nil?)
    status 404
  else
    temp.to_json
  end
end


get '/pies/:id' do
  content_type :json
  temp = Pie.get(params[:id])
  if (temp.nil?)
    status 404
  else
    temp.to_json
  end
end
