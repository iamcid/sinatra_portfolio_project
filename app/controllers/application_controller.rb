require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
  end

  get "/" do
    if !logged_in?
      erb :index
    else 
      redirect to '/users/dashboard'
    end
  end

  helpers do

    def current_user
      @user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
      !!current_user
    end
    
    def authenticate
      redirect '/login' if !logged_in?
    end

  end

end
