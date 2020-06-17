class UsersController < ApplicationController

    get '/dashboard' do
        authenticate
        @u = current_user
        erb :"users/dashboard"
    end
end