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
    redirect to('/demographic/')
  end

  get '/demographic/' do
    haml :demographic
  end

  post '/demographic/' do
    puts params
    redirect to('/incident/')
  end

  get '/incident/' do
    haml :incident
  end

  post '/incident/' do
    puts params
    redirect to('/incident-details/')
  end

  get '/incident-details/' do
    haml :incident_details
  end

  post '/incident-details/' do
    puts params
    redirect to('/review/')
  end

  get '/review/' do
    haml :review
  end

  post '/review/' do
    puts params
  end
end
