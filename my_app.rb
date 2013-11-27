require 'sinatra'
require 'yaml'

class MyApp < Sinatra::Base
  
  before do
    @posts = Dir.glob("views/posts/*.erb").map do |post_name|
    post_name.split("/").last.slice(0..-5)
    end
  end

  get "/" do 
    erb :index
  end

  get "/about" do
    erb :about
  end

  get "/portfolio" do
    erb :portfolio
  end
  
  get "/blog/:post_name" do
    page = erb("/posts/#{params[:post_name]}".to_sym, layout: false)
    page_body = page.split("\n\n", 2).last
    erb page_body
    # erb "/posts/#{params[:post_name]}".to_sym
  end
  
  def meta_data
    if @meta_data
      @meta_data
    else
      @meta_data = {}
      @posts.each do |post|
        html = erb("/posts/#{post}".to_sym, layout: false)
        meta = YAML.load(html.split("\n\n", 2).first)
        @meta_data[post] = meta
      end 
      @meta_data
    end
  end

  get "/contact" do
    erb :contact
  end
end

