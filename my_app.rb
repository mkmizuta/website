require 'sinatra'
require 'yaml'

class MyApp < Sinatra::Base
  
  before do
    @posts = Dir.glob("views/posts/*.erb").map do |post_name|
      post_name.split("/").last.gsub(".erb", "")
    end
    @sorted_posts = meta_data.sort_by {|post, date_hash| date_hash["date"]}.reverse.map{|post, date_hash| post}
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
  
  get "/blog" do
    
    @post_content = ""
    @sorted_posts.each{|post|
      page = erb "/posts/#{post}".to_sym, layout: false
      @post_content += page.split("\n\n", 2).last
    }
    erb :blog
  end

   get "/blog/:post_name" do
    page = erb "/posts/#{params[:post_name]}".to_sym, layout: false
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
        html = erb "/posts/#{post}".to_sym, layout: false
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

