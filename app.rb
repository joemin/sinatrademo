require 'sinatra'
require 'json'
require 'data_mapper'
require 'dm-migrations'

get '/' do
  File.read('cakes.html')
end

get '/cakeList.json' do
  DataMapper.setup(:default, 'sqlite:///tmp/test.db')


  class Cake
    include DataMapper::Resource

    property :id,         Serial    # An auto-increment integer key
    property :name,       String    # A varchar type string, for short strings
  end

  DataMapper.finalize

  arr = Cake.all
  arr.to_json
end
