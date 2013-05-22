# encoding: utf-8
require 'rspec'
require 'rack/test'

MY_APP = Rack::Builder.parse_file('config.ru').first

include Rack::Test::Methods
def app
  MY_APP
end

describe "Randta" do
  context "root" do
    it "last response ok?" do
      get '/'
      last_response.ok? == true
    end
  end

  context "create (HTTP POST)" do
    it "volume: 3, digit: 4, width: 5, mode: numeric" do
      post '/create', {:volume => "3",
                       :digit  => "4",
                       :width  => "5",
                       :mode  => "n"}
      last_response.ok? == true
      last_response.body.to_s.should =~ /<tr>\s+?(<td>\d{,4}<\/td>\s+?){3}\s+?<\/tr>/
    end

    it "volume: 4, digit: 1, width: 2, mode: numeric" do
      post '/create', {:volume => "4",
                       :digit  => "1",
                       :width  => "2",
                       :mode  => "n"}
      last_response.ok? == true
      last_response.body.to_s.should =~ /(<tr>\s+?(<td>\d{1}<\/td>\s+?){2}\s+?<\/tr>\s+?){2}/
    end

    it "volume: 100, digit: 4, width: 100, mode: string" do
      post '/create', {:volume => "100",
                       :digit  => "4",
                       :width  => "100",
                       :mode  => "s"}
      last_response.ok? == true
      last_response.body.to_s.should =~ /<tr>\s+?(<td>[0-9a-z]{4}<\/td>\s+?){100}<\/tr>/
    end

    it "save params" do
      post '/create', {:volume => "3",
                       :digit  => "4",
                       :width  => "5",
                       :mode  => "s"}
      last_response.ok? == true
      last_response.body.to_s.should =~ /selected.*>3</
      last_response.body.to_s.should =~ /selected.*>4</
      last_response.body.to_s.should =~ /selected.*>5</
      last_response.body.to_s.should =~ /checked.*>string</
    end
  end

  context "create (HTTP GET)" do
    it "volume: 3, digit: 4, width: 5, mode: numeric" do
      get '/create', {:volume => "3",
                       :digit  => "4",
                       :width  => "5",
                       :mode  => "n"}
      last_response.ok? == true
      last_response.body.to_s.should =~ /<tr>\s+?(<td>\d{,4}<\/td>\s+?){3}\s+?<\/tr>/
    end
  end
end
