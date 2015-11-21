require 'sinatra'
require 'sinatra/activerecord'
require 'haml'

class User < ActiveRecord::Base
end

class NoticeOfClaim < ActiveRecord::Base
end

class NOCApp < Sinatra::Base
  # multipart form
  # index -> demographic -> 
  get '/' do
    haml :index
  end

  post '/' do
    puts params
    @lawyer = params['lawyer']
    redirect to('/review/')
  end

  get '/review/' do
    haml :review
  end

  post '/review/' do
    puts params
  end
end
