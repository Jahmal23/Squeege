require 'sinatra'
require_relative 'Lib/home_page'

get '/' do
  'squeegee active!'
end

get '/squeegee' do
  #home = HomePage.new
  #home.perform_search(SessionBoss.new.capy_session, 'Oliveira', '30062')
end
