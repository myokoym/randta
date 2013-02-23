# encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'haml'
require 'uri'

get "/" do
  haml :index
end

create = lambda do
  @list = create(params)
  @volume = params[:volume].to_i
  @digit = params[:digit].to_i
  @width = params[:width].to_i
  @mode = params[:mode]
  @http_get_url = http_get_url
  haml :index
end
get "/create", &create
post "/create", &create

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
