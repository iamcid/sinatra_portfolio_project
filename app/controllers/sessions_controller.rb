class SessionsController < ApplicationController
    
    get '/login' do
        erb :"sessions/login"
    end

    get '/signup' do
        erb :"sessions/signup"
    end

    post '/signup' do
        @u = User.new(username: params[:username], password: params[:password])
        if @u.save
            session[:user_id] = @u.id
            redirect "/users/dashboard"
        else
            @u.errors.any?
            erb :"/sessions/signup"
        end
    end

    post '/login' do
        u = User.find_by(username: params[:username])
        if u && u.authenticate(params[:password])
            session[:user_id] = u.id
            redirect "/users/#{u.id}"
        else
            @error = "Invalid credentials, please try again."
            erb :"sessions/login"
        end
    end

    get '/users/:id' do
        authenticate
        erb :"users/dashboard"
    end

    get '/logout' do
        session.clear
        redirect "/"
    end
end