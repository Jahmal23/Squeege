require 'sinatra'
require_relative 'Lib/home_page'


get '/' do
  'squeegee active!'
end


get '/squeegee' do

  home = Home_Page.new
  home.perform_search(Session_Boss.new.capy_session,'Oliveira','30062')

end
