require 'sinatra'

class MyApp < Sinatra::Base
  
  get "/" do 
    erb :index
  end

  get "/contact" do
    erb :contact
  end

  get "/blog/:post_name" do
    erb "/posts/#{params[:post_name]}".to_sym
  end
end

