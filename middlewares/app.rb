require 'sinatra/base'

module ChatDemo
  class App < Sinatra::base
    get "/" do
      erb: "index.html"
    end
  end
end
