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
    it "volume: 3, digit: 4" do
      post '/create', {:volume => "3",
                       :digit => "4"}
      last_response.ok? == true
      last_response.body.to_s.should =~ /<tr>\s+?(?:<td>\d{,4}<\/td>\s+?){3}\s+?<\/tr>/
    end
  end

=begin
    it "add linefeed" do
      post '/create', {:text => "text",
                      :volume => "3",
                      :linefeed => "1"}
      last_response.ok? == true
      last_response.body.to_s.should =~ />text&#x000A;text&#x000A;text<\/textarea>/
    end

    it "increment option" do
      post '/create', {:text => "text_?;",
                      :volume => "3",
                      :linefeed => "0",
                      :increment => "1",
                      :increment_sign => "?",
                      :increment_start => "1",
                      :increment_digit => "3"}
      last_response.ok? == true
      last_response.body.to_s.should =~ />text_001;text_002;text_003;<\/textarea>/
    end

    it "increment option and '%' into textarea" do
      post '/create', {:text => "?%;",
                      :volume => "3",
                      :linefeed => "0",
                      :increment => "1",
                      :increment_sign => "?",
                      :increment_start => "100",
                      :increment_digit => "3"}
      last_response.ok? == true
      last_response.body.to_s.should =~ />100%;101%;102%;<\/textarea>/
    end

    it "template option" do
      post '/create', {:text => "text_@@@;",
                      :volume => "3",
                      :linefeed => "0",
                      :template => "1",
                      :template_sign => "@@@",
                      :template_text => "aaa\nbbb\nccc"}
      last_response.ok? == true
      last_response.body.to_s.should =~ />text_aaa;text_bbb;text_ccc;<\/textarea>/
    end

    it "print HTTP GET URL" do
      post '/create', {:text => "text",
                      :volume => "3",
                      :linefeed => "0",
                      :increment => "1",
                      :increment_sign => "?",
                      :increment_start => "1",
                      :increment_digit => "3"}
      last_response.ok? == true
      last_response.body.to_s.should =~ /text=text/
      last_response.body.to_s.should =~ /volume=3/
      last_response.body.to_s.should =~ /linefeed=0/
      last_response.body.to_s.should =~ /increment=1/
      last_response.body.to_s.should =~ /increment_sign=%3F/
      last_response.body.to_s.should =~ /increment_start=1/
      last_response.body.to_s.should =~ /increment_digit=3/
    end
  end

  context "create (HTTP GET)" do
    it "text to 3 volume" do
      get '/create', {:text => "text",
                      :volume => "3",
                      :linefeed => "0"}
      last_response.ok? == true
      last_response.body.to_s.should =~ />texttexttext<\/textarea>/
    end
  end
=end
end
