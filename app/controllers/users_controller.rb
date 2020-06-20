class UsersController < ApplicationController

    get '/users/:id' do
        authenticate
        erb :"users/dashboard"
    end

    
end