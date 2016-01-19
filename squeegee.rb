require 'sinatra'
require_relative 'Lib/loader'

get '/' do
  'squeegee active!'
end


get '/squeegee' do
  load = Loader.new
  load.get_content
end
