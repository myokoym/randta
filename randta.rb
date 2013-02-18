# encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'haml'
require 'uri'

get "/" do
  haml :index
end

get "/create" do
  @list = create(params)
  @width = params[:width].to_i
  @http_get_url = http_get_url
  haml :index
end
alias :post :get

private
def create(params)
  prng = Random.new
  results = []
  if params[:mode] =~ /^n/
    results = Array.new(params[:volume].to_i) {
                prng.rand(10 ** params[:digit].to_i - 1)
              }
  elsif params[:mode] =~ /^s/
    chars = []
    chars << ("0".."9").to_a
    chars << ("a".."z").to_a
    chars.flatten!
    results = Array.new(params[:volume].to_i) {
                Array.new(params[:digit].to_i) { chars.sample }.join
              }
  else
    raise
  end
  results
end

def http_get_url
  "#{url}?#{URI.encode_www_form(params)}"
end
