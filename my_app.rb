require 'sinatra'

class MyApp < Sinatra::Base
  
  get "/" do 
    erb :index
  end

  get "/contact" do
    erb :contact
  end
end

