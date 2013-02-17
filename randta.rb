# encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'haml'
require 'uri'

get "/" do
  haml :index
end

post "/create" do
  @list = create(params)
  @width = params[:width].to_i
  @http_get_url = http_get_url
  haml :index
end

get "/create" do
  @list = create(params)
  @width = params[:width].to_i
  @http_get_url = http_get_url
  haml :index
end

private
def create(params)
  prng = Random.new
  results = Array.new(params[:volume].to_i) do
              prng.rand(10 ** params[:digit].to_i - 1)
            end
  results
end

def http_get_url
  "#{url}?#{URI.encode_www_form(params)}"
end
